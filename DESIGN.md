---
name: Pantry
description: A kitchen stock sheet. Butcher-paper ground, charcoal ink, one herb-green accent, amber and tomato only for stock signals. Serif headings, monospaced counts, cards that read like order tickets.

# Every value below mirrors app/assets/stylesheets/tokens.css verbatim. That
# file is the source of truth; this frontmatter is the portable export. If a
# token changes there, change it here in the same commit.
colors:
  # Paper and ink
  ground: "#f5f0e6"          # page ground, butcher paper
  surface: "#fffcf6"         # cards, fields, table body
  surface-sunk: "#ebe4d6"    # table heads, wells, filter track
  ink: "#1c211e"             # headings and body
  ink-muted: "#475049"       # secondary copy
  ink-faint: "#5f665f"       # meta, captions, units
  rule: "#d8cfbd"            # hairlines and borders, never text
  rule-strong: "#b0a58f"     # field borders, the ticket perforation

  # The one accent
  accent: "#2e6a4e"          # herb green: buttons, active nav, focus ring
  accent-deep: "#1e4b37"     # hover, accent text at small sizes
  accent-tint: "#dfece3"     # accent wash behind labels

  # Stock signals, never decoration
  warn: "#8a4f06"            # below par: text and card strip
  warn-tint: "#f7e8cc"       # below par: wash
  danger: "#a3301d"          # out of stock, errors: text and card strip
  danger-tint: "#f6dfd9"     # out of stock, errors: wash

typography:
  scale:
    # Six steps at a 16px root. Every font-size in the app lands on one of these.
    label: "0.75rem"       # uppercase labels, pills, table heads
    small: "0.875rem"      # nav, meta, buttons, table cells
    body: "1rem"           # default body copy
    lead: "1.25rem"        # lead paragraphs, h3, wordmark
    title: "1.75rem"       # section titles, h2, card counts, stat values
    display: "2.5rem"      # page headings, h1
  display:
    fontFamily: '"Iowan Old Style", "Palatino Linotype", Palatino, "Book Antiqua", Georgia, serif'
    fontSize: "2.5rem"
    fontWeight: 600
    letterSpacing: "-0.015em"
    lineHeight: 1.15
  title:
    fontFamily: '"Iowan Old Style", "Palatino Linotype", Palatino, "Book Antiqua", Georgia, serif'
    fontSize: "1.75rem"
    fontWeight: 600
    lineHeight: 1.15
  body:
    fontFamily: 'ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, sans-serif'
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: 1.55
  count:
    fontFamily: 'ui-monospace, "SF Mono", Menlo, Consolas, monospace'
    fontVariantNumeric: tabular-nums
  label:
    fontFamily: 'ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, sans-serif'
    fontSize: "0.75rem"
    fontWeight: 600
    letterSpacing: "0.12em"
    textTransform: uppercase

rounded:
  sm: "3px"
  md: "6px"
  pill: "999px"

spacing:
  "3xs": "0.25rem"
  "2xs": "0.5rem"
  xs: "0.75rem"
  sm: "1rem"
  md: "1.5rem"
  lg: "2.5rem"
  xl: "4rem"

components:
  button-solid:
    backgroundColor: "{colors.accent}"
    textColor: "{colors.surface}"
    typography: "{typography.scale.small}"
    rounded: "{rounded.sm}"
    padding: "0.75rem 1.5rem"
  button-outline:
    backgroundColor: "transparent"
    textColor: "{colors.ink}"
    borderColor: "{colors.ink}"
    rounded: "{rounded.sm}"
  button-quiet:
    backgroundColor: "transparent"
    textColor: "{colors.ink-muted}"
  item-card:
    backgroundColor: "{colors.surface}"
    borderColor: "{colors.rule}"
    topStrip: "4px {colors.accent} | {colors.warn} below par | {colors.danger} out"
    rounded: "{rounded.sm}"
    padding: "1rem 1.5rem 1.5rem"
  flash-notice:
    backgroundColor: "{colors.accent-tint}"
    borderColor: "{colors.accent}"
    textColor: "{colors.accent-deep}"
  flash-alert:
    backgroundColor: "{colors.danger-tint}"
    borderColor: "{colors.danger}"
    textColor: "{colors.danger}"
  stock-tag:
    rounded: "{rounded.pill}"
    typography: "{typography.scale.label}"
  nav-link-active:
    textColor: "{colors.ink}"
    borderColor: "{colors.accent}"
---

# Pantry design system

## Principles

**A stock sheet, not a dashboard.** Pantry replaces a clipboard on the walk-in
door. Warm paper, dark ink, hairline rules. Numbers are the content, so they get
the monospaced face and tabular figures everywhere they appear.

**One accent.** Herb green (`accent`) marks what you can act on: the solid
button, the active nav item, the focus ring, a stocked item's card strip.

**Colour is a stock signal.** Amber (`warn`) means below par and tomato
(`danger`) means out of stock or an error. They never decorate, and they always
come with a word ("Below par", "Out"), never colour alone.

**Legible on a greasy tablet.** Body copy is 16px, nothing is smaller than
`label` (12px), and every text colour clears 4.5:1 on `ground` and `surface`.

## Type

Three families, six sizes.

- **Display · h1** — `display`, Iowan Old Style, weight 600. One per page.
- **Title · h2** — `title`, same family. Section heads, stat values, card counts.
- **Lead · h3** — `lead`. Item names on cards, lead paragraphs, the wordmark.
- **Body** — `body`, the system sans, line-height 1.55.
- **Small** — `small`. Nav, buttons, tables, meta.
- **Label** — `label`, weight 600, uppercase, letter-spacing 0.12em. Eyebrows,
  table heads, card categories and pills.

Quantities, prices, references and stat values use the monospaced `count`
family with tabular figures so columns line up.

## Colour

Ink comes in three tiers: `ink` for headings and body, `ink-muted` for
secondary copy, `ink-faint` for meta. `rule` and `rule-strong` are for lines
only and never carry text.

## Components

- **Item card** — `app/views/items/_item_card.html.erb`, styled in
  `item-card.css`. A ticket: 4px top strip coloured by stock status, a dashed
  perforation under the category and location, the item name at `lead`, the
  count at `title` in the monospaced face with par on the right, and a footer
  with the stock tag and supplier. Used on `/`, `/items` and supplier pages.
- **Flash** — `app/views/shared/_flash.html.erb`, styled in `flash.css`. A
  tinted bar with a round icon; notice is accent, alert is danger.
- **Button** — solid (accent fill), outline (1px ink), quiet (text only).
  All `small` type, weight 600, `rounded.sm`.
- **Segmented filter** — the location and status filters. A `surface-sunk`
  track; the current option is a `surface` chip with `aria-current`.
- **Data table** — suppliers and orders. `surface` body inside a hairline
  border, `label` heads on `surface-sunk`, numbers right-aligned.
- **Pills** — stock tags, order status and role badges. `label` type,
  `rounded.pill`, tint background with the matching deep text colour.
- **Stat** — dashboard tiles. `small` label over a `title` monospaced value;
  the below-par tile carries a 4px `warn` left border.

## Do and do not

**Do** read every colour, size, space and radius from `tokens.css`. **Do** keep
counts in the monospaced face. **Do** pair every stock colour with a word.

**Do not** add a font size outside the six steps. **Do not** hard-code a hex
value in a component stylesheet or an ERB view. **Do not** use `warn` or
`danger` for anything but stock and errors. **Do not** add shadows beyond
`--shadow-ticket`.
