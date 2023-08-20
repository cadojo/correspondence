#let degreeslist = state("degreeslist", ())

#let duration(start, stop) = {
  text(rgb(90,90,90))[
    #start #if (start != none and stop != none) { " — " } #stop
  ]
}

#let degree(
  title, field,
  school: none,
  start: none,
  stop: none,
  notes
) = {
  
  let content = [
    #grid(
      columns: (1fr, 1fr),
      heading(level: 3, (title, field).join(" ")),
      align(right)[
        #duration(start, stop)
      ]
    )
    #if school != none {
      set text(rgb(90,90,90), weight: "regular")
      v(-0.5em)
      school
    }
    #notes
  ]

  degreeslist.update(current => current + (content,))
}

#let degrees(header: "Education") = {
  locate(
    loc => {
      let content = degreeslist.final(loc)
      if content.len() > 0 {
        heading(level: 2, header)
        line(length: 100%, stroke: 1pt + black)
        content.join()
      }
    }
  )
}

