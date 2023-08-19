//
// Article Formats
//

#let article(
    title: none,
    theme: black,
    columns: 1,

    content,
) = {

    set text(font: "New Computer Modern")
    set page(paper: "us-letter")
    show heading: h => align(center, h)

    heading(level: 1, text(22pt, title))
    content
}