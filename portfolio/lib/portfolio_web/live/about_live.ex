# lib/portfolio_web/live/about_live.ex
defmodule PortfolioWeb.AboutLive do
  use PortfolioWeb.BaseLive

  def mount(_params, _session, socket) do
    experiences = [
      %{
        company: "NFI Industries",
        title: "UX Design and Frontend Developer",
        period: "2017 - Present",
        description: "UX designer collaborating with developers to create a logical working path for the Transportation Management Software (TMS). Frontend developer integrating LiveView with Tailwind framework and back-end Phoenix and Elixir systems.",
        achievements: [
          "Worked closely with cross-functional teams to ensure feature alignment and improve overall user experience",
          "Involved in all stages of software development, from planning and architecture to implementation and support",
          "Instrumental in launching several packages, resulting in increased employee productivity and organizational revenue"
        ]
      },
      %{
        company: "Calamos Investments",
        title: "Web Developer",
        period: "2015 - 2017",
        description: "Sole Frontend Web Developer for a top investment firm, responsible for designing and implementing all user-facing websites. Designed and executed campaigns for various investment products, microsites, and new pages.",
        achievements: [
          "Collaborated with the back-end developer to create templates in Sitecore CMS and upgrade the Bootstrap framework",
          "Provided support to marketing, sales, institutional, and wealth management teams for all external-facing needs",
          "Presented design concepts and user insights to stakeholders, enhancing product alignment with user needs"
        ]
      },
      %{
        company: "GKIC",
        title: "Web Designer",
        period: "2012 - 2014",
        description: "Responsible for creating and maintaining clean, well-structured web designs and providing graphic components. Led the creation of three new websites and redesigned four heavily utilized sites, including the main website.",
        achievements: [
          "Managed design elements such as wireframes, sitemaps, and mockups for web projects",
          "Ensured projects remained on track and within budget by working closely with Project Managers and Backend developers",
          "Conducted user interviews and usability tests to gather insights, which informed design decisions"
        ]
      },
      %{
        company: "PMall",
        title: "Web Designer",
        period: "2010 - 2012",
        description: "Developed UI, wireframes, sitemaps, screen mockups, and interaction design specs for optimal user experiences. Managed site updates and designed various online materials, including logos and branding materials.",
        achievements: [
          "Spearheaded the development and implementation of all online materials for marketing initiatives",
          "Conducted user interviews and usability tests to gather insights, which informed design decisions",
          "Managed design elements and maintained brand consistency across all digital touchpoints"
        ]
      }
    ]

    education = [
      %{
        institution: "DePaul University",
        degree: "Master of Science in Human-Computer Interaction",
        period: "2018",
        description: "Focused on user research methods, information architecture, interaction design, and creating accessible digital experiences."
      },
      %{
        institution: "Chicago State University",
        degree: "Bachelor of Arts with emphasis in Design",
        period: "2005",
        description: "Studied visual design principles, typography, and digital media with focus on practical application of design skills."
      }
    ]

    skills = [
      %{
        category: "Technical Skills",
        items: ["LiveView", "Phoenix", "Elixir", "VueJs", "CSS (Bootstrap/Tailwind)", "Docker", "NodeJS", "GitHub"]
      },
      %{
        category: "Design Tools",
        items: ["Figma", "Photoshop", "Illustrator", "InDesign", "AfterEffects", "Premiere"]
      },
      %{
        category: "Development",
        items: ["HTML/CSS", "JavaScript", "Frontend Development", "Responsive Design", "Design Systems", "Information Architecture"]
      },
      %{
        category: "Specialties",
        items: ["Accessibility & Inclusivity", "User-Centered Design", "Cross-Functional Collaboration", "Technical Problem Solving"]
      }
    ]

    {:ok,
      socket
      |> mount_common("about")
      |> assign(:page_title, "About Me")
      |> assign(:experiences, experiences)
      |> assign(:education, education)
      |> assign(:skills, skills)
    }
  end

  def render(assigns) do
    ~H"""
    <div id="page-container" phx-hook="PageTransition" class="min-h-screen bg-white">
      <main>
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%]">
            <div>
              <h1 id="about-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-8" phx-hook="FadeIn">
                About Me
              </h1>

              <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
                <div class="md:col-span-2" id="about-intro" phx-hook="FadeIn">
                  <p class="text-xl text-gray-600 mb-6">
                    I'm a UX designer and front-end developer based in Chicago, IL, specializing in creating user-centric designs, intuitive interfaces, and engaging user experiences.
                  </p>
                  <p class="text-gray-600 mb-6">
                    With over a decade of experience across transportation management, investment firms, and e-commerce, I combine strategic thinking with hands-on development skills. Currently working with LiveView, Phoenix, and Elixir frameworks, I deliver solutions that are both accessible and business-aligned.
                  </p>
                  <p class="text-gray-600 mb-6">
                    My approach involves working closely with cross-functional teams to ensure feature alignment and improve overall user experience, from planning and architecture to implementation and support.
                  </p>
                </div>
                <div id="about-photo" phx-hook="FadeIn">
                  <img src="/images/profile.jpg" alt="Brian Hall" class="w-full h-auto rounded-sm shadow-sm" />
                </div>
              </div>

              <div id="experience-section" class="mb-16" phx-hook="ScrollReveal">
                <h2 class="text-2xl font-light mb-6 border-b border-gray-200 pb-4">Experience</h2>

                <div class="space-y-12">
                  <%= for experience <- @experiences do %>
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                      <div class="md:col-span-1">
                        <h3 class="text-lg font-medium mb-1"><%= experience.company %></h3>
                        <p class="text-gray-500 mb-2"><%= experience.title %></p>
                        <p class="text-sm text-gray-500"><%= experience.period %></p>
                      </div>
                      <div class="md:col-span-3">
                        <p class="text-gray-600 mb-4"><%= experience.description %></p>
                        <ul class="space-y-2">
                          <%= for achievement <- experience.achievements do %>
                            <li class="flex items-start">
                              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[rgb(211,84,0)] mr-2 mt-0.5 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                              </svg>
                              <span><%= achievement %></span>
                            </li>
                          <% end %>
                        </ul>
                      </div>
                    </div>
                  <% end %>
                </div>
              </div>

              <div id="education-section" class="mb-16" phx-hook="ScrollReveal">
                <h2 class="text-2xl font-light mb-6 border-b border-gray-200 pb-4">Education</h2>

                <div class="space-y-12">
                  <%= for edu <- @education do %>
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                      <div class="md:col-span-1">
                        <h3 class="text-lg font-medium mb-1"><%= edu.institution %></h3>
                        <p class="text-gray-500 mb-2"><%= edu.degree %></p>
                        <p class="text-sm text-gray-500"><%= edu.period %></p>
                      </div>
                      <div class="md:col-span-3">
                        <p class="text-gray-600"><%= edu.description %></p>
                      </div>
                    </div>
                  <% end %>
                </div>
              </div>

              <div id="skills-section" class="mb-16" phx-hook="ScrollReveal">
                <h2 class="text-2xl font-light mb-6 border-b border-gray-200 pb-4">Skills</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                  <%= for skill_group <- @skills do %>
                    <div>
                      <h3 class="text-lg font-medium mb-4"><%= skill_group.category %></h3>
                      <div class="flex flex-wrap gap-2">
                        <%= for skill <- skill_group.items do %>
                          <span class="text-sm px-3 py-1 bg-gray-100 rounded-full"><%= skill %></span>
                        <% end %>
                      </div>
                    </div>
                  <% end %>
                </div>
              </div>

              <div id="cta-section" class="mt-16 pt-12 border-t border-gray-200" phx-hook="FadeIn">
                <h2 class="text-2xl font-light mb-6">Let's Connect</h2>
                <p class="text-gray-600 mb-8">
                  I'm always open to discussing new projects, creative ideas, or opportunities to be part of your vision. Feel free to reach out if you want to connect!
                </p>
                <div class="flex gap-4">
                  <.link navigate={~p"/contact"} class="inline-flex items-center text-[rgb(211,84,0)] hover:text-[rgb(180,70,0)] transition-colors group">
                    Get in touch
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                    </svg>
                  </.link>

                  <a href="/resume.pdf" target="_blank" class="inline-flex items-center text-gray-600 hover:text-[rgb(211,84,0)] transition-colors group ml-8">
                    Download Resume
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1 group-hover:translate-y-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                    </svg>
                  </a>
                </div>
              </div>
            </div>
          </div>

          <!-- Always show on desktop (adding visible-always-nav class) -->
            <.main_nav active={@active} />
        </div>
      </main>

      <.mobile_menu active={@active} show_menu={@show_menu} />
    </div>
    """
  end
end
