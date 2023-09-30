//
// Article Formats
//

#import "../../options/options.typ": *
#import "../../rolo/rolo.typ": *

#let builtin-columns = columns
#let builtin-outline = outline

#let article(
    title: none,
    subtitle: none,
    abstract: none,
    author: author(),
    date: datetime.today().display("[month repr:long] [day], [year]"),
    theme: black,
    columns: 2,
    header: none,
    footer: none,
    margin: 0.75in,
    font: "New Computer Modern",
    mono: "New Computer Modern Mono",
    outline: true,
    content,
) = {

    set text(11pt, font: font)
    show raw: set text(font: mono)
    
    set par(justify: true)
    set heading(numbering: "1.1 ")
    show heading: h => align(
        center, 
        pad(bottom: 0.25em, text(theme, smallcaps(h)))
    )

    set page(
        paper: "us-letter", 
        header: header,
        margin: margin,
        footer: if some(footer) { footer } else {
          set text(rgb(75,75,75))
          place(left, align(left, title))
          place(right, align(right, counter(page).display("1 / 1", both: true)))
        },
    )

    let titleblock = {
        align(center, text(theme, size: 22pt, weight: "bold", smallcaps(title)))
        if some(subtitle) {
            align(center, text(black, size: 14pt, weight: "semibold", subtitle))
        }

        if some(author) {
            set align(center)
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
    }

    titleblock

    builtin-columns(columns)[

        #if some(abstract) {
            heading(level: 1, numbering: none, outlined: false, smallcaps("abstract"))
            abstract
            // pad(top: 1em, bottom: 1em, left: (25% / 2), right: (25% / 2), abstract)
        }

        #if outline {
            builtin-outline(title: "Table of Contents", indent: auto, depth: 2)
        }
        #content
    ]
}