#let awardslist = state("awardslist", ())

#let award(
  name, date, notes,
) = {
  let title = [
    #stack(
      dir: ltr, 
      spacing: 1fr, 
      heading(level: 3, name),
      align(right)[
        #set text(rgb(90,90,90))
        #date
      ]
    )
    #notes
  ]

  awardslist.update(current => current + (title,))
}
#let awards(header: "Honors & Awards") = {
  locate(
    loc => {
      let awardslist = awardslist.final(loc)
      if awardslist.len() > 0 {
        heading(level: 2, header)
        line(length: 100%, stroke: 1pt + black)
        awardslist.join()
      }
    }
  )

}