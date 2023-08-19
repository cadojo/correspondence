# ✍️ `correspondence`

_Typst templates for resumes, cover letters, application statements, and articles!_

## Usage

Add this repository as a submodule, then add a template under `src`. Note that
each subdirectory under `src` is a self-contained template. 

```
// 
// Example
// 

#import "correspondence/src/dear.typ: statement, affiliation, contact"

#let sender = affiliation(
    given: "First",
    middle: "M",
    family: "Last",
    preferred: "Nickname"
)

#let contact = contact(
    email: link(
        "mailto:your.email@provider.com", `your.email@provider.com`
    ),
)

#let hl(content) = {
    set text(rgb("#ddcc00"), weight: "bold")
    content
}

#let theme = rgb("#ddcc00")
#show heading: text => smallcaps(text)
#show: statement.with(
    sender: sender,
    contact: contact,
    theme: theme,
    title: "Personal Statement",
)

This is a personal statement!
```

## License

All content in this repository is covered by the top-level [MIT License](/LICENSE),
**except** for the icons under `src/icons`. The icons are **not** my creation,
and are covered by their own [MIT License](/src/icons/ICONOIR).
