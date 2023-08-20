#let presentationlist = state("presentationlist", ())

#let presentation(
  organization,
  source,
  date: none,
  notes
) = {
  let content = [
    #grid(
      columns: (1fr, 1fr),
      heading(level: 3, organization),
      align(right)[
        #set text(rgb(90,90,90))
        #date 
      ]
    )
    #if source != none {
      set text(rgb(90,90,90))
      if type(source) == "string" {
        v(-0.5em)
        text(source)
      } else {
        v(-0.5em)
        text(source.join(", "))
      }
    }
    #notes
  ]

  presentationlist.update(current => current + (content,))
}
#let presentations(header: "Conference Presentations") = {
  locate(
    loc => {
      let presentationlist = presentationlist.final(loc)
      if presentationlist.len() > 0 {
        heading(level: 2, text(header))
        line(length: 100%, stroke: 1pt + black)
        presentationlist.join()
      }
    }
  )
}