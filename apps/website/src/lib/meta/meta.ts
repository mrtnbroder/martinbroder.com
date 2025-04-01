import type { Person, WebSite, WithContext } from "schema-dts"

const personSchema: WithContext<Person> = {
  "@context": "https://schema.org",
  "@type": "Person",
  "name": "Martin Broder",
  "url": "http://www.martinbroder.com",
  "jobTitle": "Design Engineer",
  "worksFor": {
    "@type": "Organization",
    "name": "Bundesdruckerei",
    "description":
      "German manufacturer for banknotes, stamps, identity cards, passports, visas, driving licences, and vehicle registration certificates.",
    "address": {
      "@type": "PostalAddress",
      "streetAddress": "Kommandantenstraße 18",
      "postalCode": "10969",
      "addressLocality": "Berlin",
      "addressCountry": "Germany",
    },
  },
  "sameAs": [
    "https://www.linkedin.com/in/martin-broder-25043470/",
    "https://x.com/mrtnbroder",
    "https://github.com/mrtnbroder",
    "https://www.instagram.com/mrtnbroder/",
    "https://www.xing.com/profile/Martin_Broder2",
  ],
}

export const websiteSchema: WithContext<WebSite> = {
  "@context": "https://schema.org",
  "@type": "WebSite",
  "url": "http://www.martinbroder.com",
  "name": "Martin Broder's Personal Website",
  "inLanguage": "en-US",
  "description":
    "The personal website of Martin Broder, a design-oriented web engineer with a focus on startups and agencies. Based in Berlin, Germany.",
  "author": personSchema,
}

export const metadata = {
  title: "Home | Martin Broder, Design Engineer",
  description:
    "Martin Broder is a Berlin based design-oriented web engineer with a focus on startups and agencies",
  opengraph: {
    title: "Home | Martin Broder, Design Engineer",
    description:
      "Martin Broder is a Berlin based design-oriented web engineer with a focus on startups and agencies",
    image: "https://dev.martinbroder.com/images/summary_large_image.jpg",
    url: "http://www.martinbroder.com",
    sitename: "Martin Broder's Personal Website",
  },
  twitter: {
    title: "Home | Martin Broder, Design Engineer",
    description:
      "Martin Broder is a Berlin based design-oriented web engineer with a focus on startups and agencies",
    creator: "@mrtnbroder",
    cardType: "summary_large_image",
    image: "https://dev.martinbroder.com/images/summary_large_image.jpg",
    imageAlt:
      "Martin Broder is a Berlin based design-oriented web engineer with a focus on startups and agencies and available for hire.",
  },
}
