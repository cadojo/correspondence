//
// Preamble
//

#import "../../rolo/rolo.typ": *
#import "../../options/options.typ": some

#let cover(
  sender: author(),
  recipient: author(),
  regarding: none,
  logo: none,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  theme: black,
  divider: true,
  header: "default",
  footer: "default",
  body,
) = {


    set stack(spacing: 1em)
    set par(justify: true)
    show par: set block(spacing: 2em)

    set page(
        fill: white,
        background: locate(
          loc => {
            let current_page = counter(page).at(loc).at(0)
            if current_page == 1 {
              place(top, rect(fill: theme, width: 100%, height: 1.75in))
            } else {
              none
            }
          }
        ),
        header: if type(header) == "string" and lower(header) == "default" {
            locate(
              loc => {
                  let current_page = counter(page).at(loc).at(0)
                  if current_page == 1 {
                    let content = {
                      set text(11pt, white)
                      stack(
                        dir: ltr,
                        stack(
                          dir: ttb, 
                          spacing: 2em,
                          1fr, 
                          align(left, text(28pt, weight: "bold", fullname(sender.name))),
                          if some(regarding) { 
                            text(12pt, "Regarding: ") + text(size: 12pt, weight: "bold", regarding) 
                          } else { none },
                          1fr,
                        ),
                        1fr,
                        align(
                          left, 
                          stack(
                            dir: ttb,
                            spacing: 0.65em,
                            1fr,
                            ..contact(sender),
                            1fr,
                          )
                        )
                      )
                    }
                    place(top, block(height: 1.75in, content))
                }
            }
            )
        } else { header },
        footer: if type(footer) == "string" and lower(footer) == "default" {
            locate(
                loc => {
                    let pages = counter(page).final(loc).at(0)
                    if pages > 1 {
                    set text(rgb(50,50,50))
                    place(left, align(left, regarding))

                    place(right, align(right, counter(page).display("1 / 1", both: true)))
                    }
                }
            )
        } else { 
          footer 
        },
    )

    v(1in)

    let to = if recipient == none {
      none
    } else { 
      set text(rgb(50,50,50))
      move(dx: -0.5in, text(weight: "semibold", "To: "))
      stack(
      dir: ttb,
      spacing: 0.65em,
        ..(fullname(recipient.name), recipient.roles, recipient.affiliations.at(0).department, recipient.affiliations.at(0).name).filter(some),
        ..address(recipient),
      )
    }
    // Write

    if some(to) {
      align(left, to)
    }

    body
}