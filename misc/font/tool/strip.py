#!/usr/bin/python3
import fontforge
import argparse
import sys

def subset_font(input_file, output_file):
    try:
        font = fontforge.open(input_file)
        keep_glyphs = (
            [chr(ord('a') + i) for i in range(26)] +  # a-z 小写字母
            [chr(ord('A') + i) for i in range(26)]    # A-Z 大写字母
        )

        # 获取所有字形并转换为列表（避免在迭代时修改）
        all_glyphs = list(font.glyphs())

        for glyph in all_glyphs:
            if glyph.glyphname not in keep_glyphs:
                font.removeGlyph(glyph)

        # 确保必须保留的字形存在
        for char in keep_glyphs:
            if char not in font:
                print(f"Warning: Glyph '{char}' not found in font", file=sys.stderr)

        font.generate(output_file)
        print(f"Successfully created subset font: {output_file}")
        return 0
    except Exception as e:
        print(f"Error: {str(e)}", file=sys.stderr)
        return 1

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Create a font subset containing only a-z letters",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument("--input-file", "-i", required=True,
                       help="Input font file path")
    parser.add_argument("--output-file", "-o", required=True,
                       help="Output font file path")

    args = parser.parse_args()
    sys.exit(subset_font(args.input_file, args.output_file))
