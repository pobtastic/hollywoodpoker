#!/usr/bin/env python3
import inflect
import sys
import os
import argparse
from collections import OrderedDict
from disassemble import Disassemble

try:
    from skoolkit.snapshot import get_snapshot
    from skoolkit import tap2sna, sna2skool
except ImportError:
    SKOOLKIT_HOME = os.environ.get('SKOOLKIT_HOME')
    if not SKOOLKIT_HOME:
        sys.stderr.write('SKOOLKIT_HOME is not set; aborting\n')
        sys.exit(1)
    if not os.path.isdir(SKOOLKIT_HOME):
        sys.stderr.write('SKOOLKIT_HOME={}; directory not found\n'.format(SKOOLKIT_HOME))
        sys.exit(1)
    sys.path.insert(0, SKOOLKIT_HOME)
    from skoolkit.snapshot import get_snapshot
    from skoolkit import tap2sna, sna2skool

HOLLYWOODPOKER_HOME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUILD_DIR = '{}/sources'.format(HOLLYWOODPOKER_HOME)
HOLLYWOODPOKER_Z80 = '{}/HollywoodPoker.z80'.format(HOLLYWOODPOKER_HOME)


class HollywoodPoker:
    def __init__(self, snapshot):
        self.snapshot = snapshot

    def address(self, addr):
        return self.snapshot[addr] + self.snapshot[addr + 0x01] * 0x100

    def get_cards(self):
        lines = []
        p = inflect.engine()
        pc = 0xE436
        stop = 0xE544
        num = 0x02
        lines.append(f"b ${pc:04X} Graphics: Cards")
        while (pc <= stop):
            if (num == 11):
                lines.append(f"@ ${pc:04X} label=Graphics_CardAce")
            else:
                lines.append(f"@ ${pc:04X} label=Graphics_Card{p.number_to_words(num).capitalize()}")
            lines.append(f"  ${pc:04X},$1E,$06 #UDGTABLE {{")
            if (num == 11):
                lines.append(f".   #UDGS$06,$05(card-ace)(")
            else:
                lines.append(f".   #UDGS$06,$05(card-{p.number_to_words(num)})(")
            lines.append(".     #LET(a=$E35F+(#PEEK(#PC+$06*$y+$x)*$08))")
            lines.append(".     #UDG({a})(*udg)")
            lines.append(".     udg")
            lines.append(".   )")
            lines.append(". } UDGTABLE#")
            pc += 0x1E
            num += 0x01
        return '\n'.join(lines)

    def get_picturecards(self):
        lines = []
        pc = 0xE820
        stop = 0xF4C7
        lines.append(f"b ${pc:04X} Graphics: Picture Cards")
        cards = ['Jack', 'Queen', 'King']
        suits = ['Diamonds', 'Hearts', 'Spades', 'Clubs']
        index = 0x00
        while (pc <= stop):
            card = cards[index // 4 % 3]
            suit = suits[index % 4]
            lines.append(f"@ ${pc:04X} label=Graphics_Card{card}{suit}Data")
            lines.append(f"  ${pc:04X},$08 #UDGTABLE {{ #N((#PC-${pc-0x0208:04X})/$08) | #UDG(#PC) }} UDGTABLE#")
            lines.append(f"L ${pc:04X},$08,$1E")
            pc += 0xF0
            lines.append(f"@ ${pc:04X} label=Graphics_Card{card}{suit}AttributeData")
            lines.append(f"  ${pc:04X},$1E,$06 Attributes.")
            lines.append("")
            pc += 0x1E
            index += 0x01
        return '\n'.join(lines)

    def get_disassembly(self):
        pc = 0x8E5A
        end = 0x8EE1
        lines = Disassemble(get_snapshot(HOLLYWOODPOKER_Z80), pc, end)
        return lines.run()


def run(subcommand):
    if not os.path.isdir(BUILD_DIR):
        os.mkdir(BUILD_DIR)
    if not os.path.isfile(HOLLYWOODPOKER_Z80):
        tap2sna.main(('-d', BUILD_DIR, '@{}/hollywoodpoker.t2s'.format(HOLLYWOODPOKER_HOME)))
    hollywoodpoker = HollywoodPoker(get_snapshot(HOLLYWOODPOKER_Z80))
    ctlfile = '{}/{}.ctl'.format(BUILD_DIR, subcommand)
    with open(ctlfile, 'wt') as f:
        f.write(getattr(hollywoodpoker, methods[subcommand][0])())


###############################################################################
# Begin
###############################################################################
methods = OrderedDict((
    ('cards', ('get_cards', 'Cards Graphic Data (58422-58721)')),
    ('disassemble', ('get_disassembly', 'Disassemble')),
    ('picturecards', ('get_picturecards', 'Picture Cards Graphic Data (59424-62663)'))
))
subcommands = '\n'.join('  {} - {}'.format(k, v[1]) for k, v in methods.items())
parser = argparse.ArgumentParser(
    usage='%(prog)s SUBCOMMAND',
    description="Produce a skool file snippet for \"Hollywood Poker\". SUBCOMMAND must be one of:\n\n{}".format(
        subcommands),
    formatter_class=argparse.RawTextHelpFormatter,
    add_help=False
)
parser.add_argument('subcommand', help=argparse.SUPPRESS, nargs='?')
namespace, unknown_args = parser.parse_known_args()
if unknown_args or namespace.subcommand not in methods:
    parser.exit(2, parser.format_help())
run(namespace.subcommand)
