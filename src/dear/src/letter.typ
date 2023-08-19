//
// Preamble
//

#import "affiliation.typ": *

#let letter(
  sender: affiliation(),
  recipient: affiliation(),
  contact: contact(),
  subject: none,
  logo: none,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  theme: black,
  greeting: "Dear",
  closing: "Sincerely",
  divider: true,
  body,
) = {


    set stack(spacing: 1em)
    set text(font: "New Computer Modern", size: 12pt)
    show par: set block(spacing: 1.5em)
    show link: set text(weight: "bold")

    set page(
        margin: (
          top: 0.5in,
          rest: 0.75in,
        ),
        header-ascent: 0%,
    )

    let from = if sender == none {
      none
    } else {
      stack(
      dir: ttb,
        spacing: 1em,
        ..(fullname(sender), sender.role, sender.department, sender.organization).filter(some),
        ..address(sender),
      )
    }
    
    let socials = if contact == none {
      none 
    } else {
      (contact.phone, contact.website, contact.email).filter(some)
    }

    let to = if recipient == none {
      none
    } else { 
      stack(
      dir: ttb,
        spacing: 1em,
        ..(fullname(recipient), recipient.role, recipient.department, recipient.organization).filter(some),
        ..address(recipient),
      )
    }

    // Write
    
    if some(logo) {
      pad(1em, place(top, logo))
    }

    if some(from) {
      pad(bottom: 1em, align(right, from))
    }

    if some(socials) {
      align(right, stack(spacing: 1em, ..socials))
    }

    if some(to) {
      pad(top: 1em, align(left, to))
    }

    align(
      right,
      stack(
        dir: ttb,
        spacing: 1em,
        date,
        text(weight: "bold", subject),
      )
    )

    if divider {
      line(length: 100%, stroke: 1pt + black)
    }


    if some(greeting) and some(recipient) and some(recipient.name) {
      pad(bottom: 1em, greeting + " " + name(recipient) + ",")
    }

    body

    if some(closing) and some(sender) and some(name(sender)) {
      pad(
        top: 1em, 
        {
          closing + ","
          linebreak()
          text(weight: "bold", name(sender))
        }
      )
    }
}