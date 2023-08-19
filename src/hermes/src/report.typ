//
// Article Formats
//

#import "../../options/options.typ": *
#import "../../rolo/rolo.typ": *

#let builtin-outline = outline

#let description(body) = {

    set text(14pt)

    v(1fr)
    body
    v(2fr)
    pagebreak()
}

#let report(
    title: none,
    author: author(),
    date: datetime.today().display("[month repr:long] [day], [year]"),
    theme: black,
    header: none,
    footer: none,
    abstract: none,
    titlepage: none,
    outline: true,
    content,
) = {

    set text(12pt, font: "New Computer Modern")
    show raw: set text(font: "New Computer Modern Mono")

    set par(justify: true)
    set heading(numbering: "1.1 ", supplement: [Section])
    show heading: h => pad(bottom: 0.25em, h)
    show heading.where(level: 1): set heading(supplement: [Chapter])
    show heading.where(level: 1): h => {
        if h.outlined {
            pagebreak(weak: true)
            text(32pt, theme, "Chapter " + counter(heading).display())
            v(2em)
            text(32pt, theme, h.body)
        } else {
            align(center, text(32pt, theme, h))
        }
    }

    show heading.where(level: 2): set text(18pt)
    show heading.where(level: 3): set text(14pt)

    show builtin-outline.entry.where(
        level: 1
    ): e => {
        v(0.65em, weak: false)
        link(e.element.location(), text(18pt, weight: "bold", e.body))
        h(1fr)
        e.page
        v(0.65em, weak: true)
    }

    set page(
        paper: "us-letter", 
        header: header,
        margin: 1in,
        footer: if some(footer) { footer } else {
          set text(12pt, weight: "regular", rgb(75,75,75))
          place(left, align(left, title))
          place(right, align(right, counter(page).display("1 / 1", both: true)))
        },
    )

    let titleblock = {
        v(1fr)
        align(center, text(theme, size: 32pt, weight: "bold", 
        smallcaps(title)))

        if some(date) {
            align(center, date)
        }

        if some(author) {
            pad(
                1em,
                if type(author) == "array" {
                    stack(dir: ltr, ..author.map(authorblock))
                } else if type(author) == "string" {
                    author
                } else {
                    authorblock(author)
                }
            )
        }

        if some(abstract) {
            pad(top: 1em, bottom: 1em, left: 5%, right: 5%, text(style: "italic", abstract))
        }

        v(1fr)

        if some(titlepage) {
            titlepage
        }

        pagebreak()
    }

    titleblock

    if outline {
        builtin-outline(title: "Table of Contents", indent: auto, depth: 2)
    }

    content
}