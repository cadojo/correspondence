//
// Article Formats
//

#import "../../options/options.typ": *
#import "../../rolo/rolo.typ": *

#let builtin-columns = columns

#let article(
    title: none,
    abstract: none,
    author: author(),
    date: datetime.today().display("[month repr:long] [day], [year]"),
    theme: black,
    columns: 2,
    header: none,
    footer: none,
    content,
) = {

    set text(11pt, font: "New Computer Modern")
    show raw: set text(font: "New Computer Modern Mono")
    
    set par(justify: true)
    set heading(numbering: "1.1 ")
    show heading: h => align(
        center, 
        pad(bottom: 0.25em, text(theme, smallcaps(h)))
    )

    set page(
        paper: "us-letter", 
        header: header,
        margin: 0.5in,
        footer: if some(footer) { footer } else {
          set text(rgb(75,75,75))
          place(left, align(left, title))
          place(right, align(right, counter(page).display("1 / 1", both: true)))
        },
    )

    let titleblock = {
        align(center, text(theme, size: 22pt, weight: "bold", smallcaps(title)))

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
            pad(top: 1em, bottom: 1em, left: (25% / 2), right: (25% / 2), text(style: "italic", abstract))
        }
    }

    titleblock
    builtin-columns(columns)[
        #content
    ]
}