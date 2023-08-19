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
      columns: (70%, 28%, 1fr),
      heading(level: 2, (title, field).join(" ")),
      align(right)[
        #duration(start, stop)
      ]
    )
    #if school != none {
      set text(rgb(90,90,90), weight: "regular")
      v(-0.75em)
      school
    }
    #notes
  ]

  degreeslist.update(current => current + (content,))
}

#let degrees(header: "Education", size: 11pt) = {
  locate(
    loc => {
      let content = degreeslist.final(loc)
      if content.len() > 0 {
        heading(level: 1, header)
        line(length: 97%)
        content.join()
      }
    }
  )
}

