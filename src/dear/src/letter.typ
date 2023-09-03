//
// Preamble
//

#import "../../rolo/rolo.typ": *
#import "../../options/options.typ": some

#let letter(
  sender: author(),
  recipient: author(),
  subject: none,
  logo: none,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  theme: black,
  greeting: "Dear",
  closing: "Sincerely",
  divider: true,
  header: none,
  footer: "default",
  body,
) = {


    set stack(spacing: 1em)
    set text(font: "New Computer Modern", size: 12pt)
    set par(justify: true)
    show par: set block(spacing: 1.5em)

    set page(
        header: header,
        footer: if type(footer) == "string" and lower(footer) == "default" {
          locate(loc => {
            let pages = counter(page).final(loc).at(0)
            if pages > 1 {
              set text(rgb(75,75,75))
              place(left, align(left, subject))

              place(right, align(right, counter(page).display("1 / 1", both: true)))
            }
          }
          
          )

        } else { 
          footer 
        },
    )

    if header == none { v(-0.5in) }

    let from = if sender == none {
      none
    } else {
      stack(
      dir: ttb,
        spacing: 1em,
        ..(fullname(sender.name), sender.roles, sender.affiliations.at(0).department, sender.affiliations.at(0).name).filter(some),
        ..address(sender),
      )
    }
    
    let socials = if sender == none {
      none 
    } else {
      (sender.phone, sender.url, sender.email).filter(some)
    }

    let to = if recipient == none {
      none
    } else { 
      stack(
      dir: ttb,
        spacing: 1em,
        ..(fullname(recipient.name), recipient.roles, recipient.affiliations.at(0).department, recipient.affiliations.at(0).name).filter(some),
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


    if some(greeting) {
      to = if some(nickname(recipient.name)) {
        nickname(recipient.name)
      } else if some(recipient.roles) {
        recipient.roles
      } else {
        none
      }

      if some(to) {
        pad(bottom: 1em, greeting + " " + to + ",")
      }
    }

    show link: set text(theme)

    body

    if some(closing) and some(sender) and some(sender.name) {
      pad(
        top: 1em, 
        {
          stack(
            dir: ttb, 
            closing + ",",
            text(weight: "bold", nickname(sender.name))
          )
        }
      )
    }
}