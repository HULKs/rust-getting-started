#import "@preview/polylux:0.3.1": *

#let slide-footer = state("slide-footer", [])

#let slide-cell = block.with(
  width: 100%,
  height: 100%,
  above: 0pt,
  below: 0pt,
  breakable: false,
)

#let slide-progress-bar = utils.polylux-progress( ratio => {
  grid(
    columns: (ratio * 100%, 1fr),
    slide-cell(fill: black.lighten(20%)),
    slide-cell(fill: white.darken(20%)),
  )
})

#let workshop-theme(aspect-ratio: "16-9", footer: [], body) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
    header-ascent: 0em,
    footer-descent: 0em,
  )
  set text(
    fill: black,
    size: 23pt,
    font: "Helvetica Neue",
  )

  show raw: set text(
    font: "JetBrains Mono",
  )

  slide-footer.update(footer)

  body
}

#let title-slide(
  title: [],
  subtitle: none,
  author: none,
  date: none,
  extra: none,
) = {
  let content = {
    set align(horizon)
    block(width: 100%, inset: 2em, {
      text(size: 1.3em, strong(title))
      if subtitle != none {
        linebreak()
        text(size: 0.9em, subtitle)
      }
      line(length: 100%, stroke: .05em + rgb("#eb811b"))
      set text(size: .8em)
      if author != none {
        block(spacing: 1em, author)
      }
      if date != none {
        block(spacing: 1em, date)
      }
      set text(size: .8em)
      if extra != none {
        block(spacing: 1em, extra)
      }
    
    })
  }
  polylux-slide(content)
}

#let slide(
  title: none,
  body
) = {
  let header = {
    if title != none {
      set align(horizon)
      set text(size: 1.2em)
      slide-cell(inset: 1em, strong(title))
    } else {
      []
    }
  }

  let footer = {
    set text(size: 0.8em, fill: gray)
    set align(bottom)
    slide-cell(
      inset: (left: 1em, right: 1em),
      {
        slide-footer.display()
        h(1fr)
        logic.logical-slide.display()
      }
    )
    v(0.5em)

    slide-cell(height: 2pt, slide-progress-bar)
  }

  set page(
    header: header,
    footer: footer,
    margin: (top: 3em, bottom: 2em),
  )

  let content = {
    set align(horizon)
    show: pad.with(left: 2em, right: 2em)
    body 
  }

  logic.polylux-slide(content)
}


#let new-section-slide(name) = {
  let content = {
    utils.register-section(name)
    set align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em)
    name
    block(height: 2pt, width: 100%, spacing: 0pt, slide-progress-bar)
  }
  logic.polylux-slide(content)
}

