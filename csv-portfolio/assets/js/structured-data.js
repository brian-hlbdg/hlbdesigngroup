// /csv-portfolio/assets/js/structured-data.js

/**
 * Load structured data dynamically for SEO
 */
document.addEventListener('DOMContentLoaded', function() {
    // Create the structured data
    const structuredData = {
      "@context": "https://schema.org",
      "@type": "Person",
      "name": "Brian H.",
      "jobTitle": "UX Designer & Frontend Developer",
      "url": "https://hlbdesigngroup.com",
      "image": "https://hlbdesigngroup.com/images/profile.jpg",
      "email": "brian.HLBDG@outlook.com",
      "sameAs": [
        "https://www.facebook.com/hlbdg",
        "https://www.linkedin.com/in/hlbdg/",
        "https://www.instagram.com/hlbdg/",
        "https://bsky.app/profile/hlbdg"
      ],
      "worksFor": {
        "@type": "Organization",
        "name": "NFI Industries"
      },
      "alumniOf": [
        {
          "@type": "EducationalOrganization",
          "name": "DePaul University",
          "url": "https://www.depaul.edu"
        }
      ],
      "knowsAbout": [
        "UX Design",
        "UI Design",
        "Frontend Development",
        "Phoenix LiveView",
        "Elixir",
        "User Experience",
        "Product Design"
      ],
      "address": {
        "@type": "PostalAddress",
        "addressLocality": "Chicago",
        "addressRegion": "IL",
        "addressCountry": "US"
      }
    };
  
    // Create script element
    const script = document.createElement('script');
    script.type = 'application/ld+json';
    script.textContent = JSON.stringify(structuredData);
    
    // Append to head
    document.head.appendChild(script);
  });