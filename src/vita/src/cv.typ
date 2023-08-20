//
// Preamble
//

#import "experience.typ": *
#import "research.typ": *
#import "references.typ": *
#import "presentations.typ": *
#import "publications.typ": *
#import "teaching.typ": *
#import "education.typ": *
#import "projects.typ": *
#import "skills.typ": *
#import "socials.typ": *
#import "awards.typ": *

#import "../../rolo/rolo.typ": *

#let cv(
  author: author(),
  title: none,
  date: datetime.today().display("[month repr:long] [year]"),
  divider: true,
  theme: black,
  header: none,
  footer: none,
  body: stack(spacing: 1.25em, degrees(), researching(), teachings(), experiences(), publications(), presentations(), awards(), references()),
  metadata
) = {
    show heading.where(level: 1): set text(22pt, theme)
    show heading.where(level: 2): set text(16pt, theme)
    show heading.where(level: 3): set text(12pt)


    set stack(spacing: 1em)
    set text(font: "New Computer Modern", size: 10pt)
    set par(justify: true)

    let titleblock = if some(title) { 
      align(center, heading(level: 1, text(size: 22pt, title)))
      if divider {
        pad(top: 1em, line(length: 100%, stroke: 1pt + black))
      } 
      if some(author) {
        set text(rgb(75,75,75))
        stack(dir: ltr, spacing: 1fr, authorblock(author))
      }

    } else {
        align(center, heading(level: 1, text(size: 22pt, fullname(author.name))))
        if divider {
          pad(top: 1em, line(length: 100%, stroke: 1pt + black))
        } 
        if some(author) {
          set text(rgb(75,75,75))
          stack(
            dir: ltr, 
            spacing: 1fr,
            align(left, address(author).join("\n")),
            align(right, contact(author).join("\n")),
          )
        }
    }

    set page(
        margin: 0.75in,
        header: header,
        header-ascent: 1em,
        footer: if some(footer) { footer } else {
          set text(rgb(75,75,75))
          place(left, align(left, "Curriculum Vitae"))
          place(right, align(right, counter(page).display("1 / 1", both: true)))
        },
    )

    move(dy: -1em, titleblock)
    show link: set text(theme)

    metadata

    stack(
      dir: ttb,
      body,
    )
}