//
// Preamble
//

#import "../../rolo/rolo.typ": *

#let statement(
  sender: author(),
  logo: none,
  title: "Statement of Purpose",
  date: datetime.today().display("[month repr:long] [day], [year]"),
  divider: true,
  theme: black,
  header: none,
  footer: none,
  body,
) = {

    set stack(spacing: 1em)
    set text(font: "New Computer Modern", size: 12pt)
    set par(justify: true)
    show heading: set text(theme)
    show par: set block(spacing: 1.5em)

    let titleblock = if some(title) { 
      align(center, heading(level: 1, text(size: 22pt, title)))
      if divider {
        pad(top: 1em, line(length: 100%, stroke: 1pt + black))
      }
      if some(sender) {
        set text(rgb(75,75,75))
        stack(dir: ltr, spacing: 1fr, ..(fullname(sender), sender.email).filter(some))
      }

    } else {
      none
    }
    set page(
        header: header,
        header-ascent: 1em,
        footer: if some(footer) { footer } else {
          set text(rgb(75,75,75))
          place(left, align(left, date))
          place(right, align(right, counter(page).display("1 / 1", both: true)))
        },
    )

    move(dy: -1em, titleblock)
    show link: set text(theme)

    body
}