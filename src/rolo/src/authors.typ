#import "names.typ": name, fullname
#import "attributes.typ": attributes
#import "affiliations.typ": affiliation

#import "../../options/options.typ": some

#let author(
    number: none,
    name: name(),
    url: none,
    email: none,
    phone: none,
    fax: none,
    orcid: none,
    note: none,
    acknowledgements: none,
    attributes: attributes(),
    roles: none,
    metadata: none,
    affiliations: affiliation(),
) = (
    number: number,
    name: name,
    url: url,
    email: email,
    phone: phone,
    fax: fax,
    orcid: orcid,
    note: note,
    acknowledgements: acknowledgements,
    attributes: attributes,
    roles: roles,
    metadata: metadata,
    affiliations: affiliations,
)

#let address(author) = (
    if some(author) {
        let state = (author.affiliations.region, author.affiliations.postal-code).filter(some).join(" ")
        let location = (author.affiliations.city, state).filter(some).join(", ")
        (location, author.affiliations.country).filter(some)
    } else {
        none
    }
)

