// Typst custom formats typically consist of a 'typst-template.typ' (which is
// the source code for a typst template) and a 'typst-show.typ' which calls the
// template's function (forwarding Pandoc metadata values as required)
//
// This is an example 'typst-show.typ' file (based on the default template  
// that ships with Quarto). It calls the typst function named 'article' which 
// is defined in the 'typst-template.typ' file. 
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-template.typ' entirely. You can find
// documentation on creating typst templates here and some examples here:
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#show: doc => $if(report)$report$else$article$endif$(
$if(title)$
  title: [$title$],
$endif$
$if(theme)$
  theme: $theme$,
$endif$
$if(by-author)$
  author: (
$for(by-author)$
$if(it.name)$
    author( 
      name: name(
        $if(it.name.given)$
        given: "$it.name.given$",
        $endif$
        $if(it.name.family)$
        family: "$it.name.family$",
        $endif$
        $if(it.name.literal)$
        literal: "$it.name.literal$",
        $endif$
        $if(it.name.dropping-particle)$
        dropping-particle: "$it.name.dropping-particle$",
        $endif$
        $if(it.name.non-dropping-particle)$
        non-dropping-particle: "$it.name.non-dropping-particle$",
        $endif$
      ),
      $if(it.name.url)$
      url: "$it.name.url$",
      $endif$
      $if(it.name.email)$
      email: "$it.name.email$",
      $endif$
      $if(it.name.phone)$
      phone: "$it.name.phone$",
      $endif$
      $if(it.name.fax)$
      fax: "$it.name.rax$",
      $endif$
      $if(it.name.orcid)$
      orcid: "$it.name.orcid$",
      $endif$
      $if(it.name.note)$
      note: "$it.name.note$",
      $endif$
      $if(it.name.acknowledgements)$
      acknowledgements: "$it.name.acknowledgements$",
      $endif$
      $if(it.name.roles)$
      roles: "$it.name.roles$",
      $endif$
      $if(it.affiliations)$
      affiliations: (
        $for(it.affiliations)$
        affiliation(
          $if(it.name)$
          name: "$it.name$",
          $endif$
          $if(it.department)$
          department: "$it.department$",
          $endif$
          $if(it.address)$
          address: "$it.address$",
          $endif$
          $if(it.city)$
          city: "$it.city$",
          $endif$
          $if(it.region)$
          region: "$it.region$",
          $endif$
          $if(it.country)$
          country: "$it.country$",
          $endif$
          $if(it.postal-code)$
          postal-code: "$it.postal-code$",
          $endif$
          $if(it.url)$
          urle: "$it.url$",
          $endif$
        )
        $endfor$
      ),
      $endif$
      email: [$it.email$] ),
$endif$
$endfor$
    ),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(monofont)$
  mono: ("$monofont$"),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(toc)$
  outline: $toc$,
$endif$
  $if(report)$$else$
  columns: $if(columns)$$columns$$else$1$endif$,
  $endif$
  doc,
)
