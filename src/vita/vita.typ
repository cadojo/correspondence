//
// Preamble
//

#import "src/experience.typ": *
#import "src/education.typ": *
#import "src/projects.typ": *
#import "src/skills.typ": *
#import "src/socials.typ": *

#let decorated(src, body) = {
  if src == none {
    body
  } else {
    stack(dir: ltr, move(dy: 0.4em, src), h(0.5em), body)
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
  side: stack(projects(), socials(),),
  metadata,
) = {

  show link: set text(weight: "bold")
  set text(
    size: 9pt,
  )

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
          #v(2em)
          #set text(34pt, weight: "bold")
          #name
        ],
        [
          #v(1.5em)
          #align(
            right, 
            stack(
              dir: ttb,
              spacing: 2em,
              text(18pt, title),
              if url != none {
                text(9pt, style: "italic", "Available at " + url)
              }
            )
          )
        ]
      ),
      none,
      [
        #set text(size: 11pt, white)
        #v(1em)
        #block(
          align(left)[
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
  
  show heading.where(level: 1): set text(size: 20pt, theme.darken(10%))
  show heading.where(level: 2): set text(size: 13pt)

  metadata

  grid(
    columns: (67%, 1fr, 29%),
    stack(
      dir: ttb,
      spacing: 1.5em,
      body,
    ), "",
    stack(dir: ttb)[
      #locate(
        loc => {
          show heading.where(level: 1): set text(white)
          show heading.where(level: 1): set align(center)
          set text(white)
          side
        }
      )   
    ]
  )
}

#let cv(
  name: none,
  email: none,
  phone: none,
  links: none,
  title: "Professional Resume",
  theme: rgb(120,120,120),
  body: stack(spacing: 1.25em, experiences(), degrees(), skills()),
  metadata
) = {
    let subtitle = (email, phone, ..links).join(" • ")
    let header = stack(
      spacing: 1.5em,
      text("Joey Carpinelli", size: 18pt),
      if subtitle.len() > 4 { 
         
        subtitle } 
    )
    set page(
      margin: 1in,
      header: align(center, header),
    )
}