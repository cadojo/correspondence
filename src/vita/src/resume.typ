//
// Preamble
//

#import "experience.typ": *
#import "education.typ": *
#import "projects.typ": *
#import "skills.typ": *
#import "socials.typ": *

#let decorated(src, body) = {
  if src == none {
    body
  } else {
    stack(dir: ltr, spacing: 0.5em, move(dy: 0.5em, src), h(0.5em), body)
  }
}

#let resume(
  name: none,
  email: none,
  phone: none,
  title: "Professional Resume",
  url: none,
  theme: rgb(120,120,120),
  body: stack(spacing: 1.25em, experiences(), degrees(), skills()),
  side: stack(projects(), socials()),
  metadata,
) = {
  show heading.where(level: 1): set text(32pt, black)
  show heading.where(level: 2): set text(18pt)
  show heading.where(level: 3): set text(12pt)

  set stack(spacing: 1em)
  set text(size: 9pt)
  show link: set text(weight: "bold")

  set page(
    margin: (
      "left": 0.3in,
      "right": 0.3in,
      "top": 1in,
      "bottom": 0.5in,
    ), 
    fill: white,
    background: place(
        right + bottom, rect( 
        fill: theme,      
        height: 100%,      
        width: 33%,    
      )
    ),
    paper: "us-letter", 
    header: grid(
      columns: (67%, 1fr, 29%),
      grid(
        columns: (1.75fr, 1fr),
        [
          #heading(level: 1, name)
        ],
        [
          #v(1.5em)
          #align(
            right, 
            stack(
              dir: ttb,
              spacing: 1em,
              heading(level: 3, title),
              if url != none {
                text(9pt, style: "italic", "Available at " + url)
              }
            )
          )
        ]
      ),
      none,
      [
        #pad(
          top: 1em,
          align(left)[
            #set text(white, 11pt)
            #stack(
              dir: ttb,
              spacing: 1.75em,
              phone,
              email,
            )
          ]
        )
      ]
    ),
   header-ascent: 0.5in,
  )

  metadata

  grid(
    columns: (67%, 1fr, 29%),
    stack(
      dir: ttb,
      spacing: 1.5em,
      [
        #show heading.where(level: 2): set text(theme)
        #show heading.where(level: 2): set align(left)
        #body
      ],
    ), "",
    [
      #set text(white)
      #show heading.where(level: 2): set align(center)
      #side
    ]
  )
}
