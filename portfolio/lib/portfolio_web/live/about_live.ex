# lib/portfolio_web/live/about_live.ex
defmodule PortfolioWeb.AboutLive do
  use PortfolioWeb.BaseLive

  def mount(_params, _session, socket) do
    experiences = [
      %{
        company: "Design Studio X",
        title: "Senior UX Designer",
        period: "2021 - Present",
        description: "Lead designer for financial and healthcare clients, focusing on complex application redesigns and design systems. Mentor junior designers and facilitate design thinking workshops.",
        achievements: [
          "Redesigned a healthcare portal that increased patient engagement by 45%",
          "Created a design system that reduced development time by 35%",
          "Led a team of 3 designers on a major fintech application redesign"
        ]
      },
      %{
        company: "Tech Innovations Inc.",
        title: "UX/UI Designer",
        period: "2018 - 2021",
        description: "Designed user interfaces and experiences for web and mobile applications in the e-commerce and travel sectors. Collaborated with product managers and engineers to implement user-centered design solutions.",
        achievements: [
          "Designed a mobile booking flow that increased conversion by 28%",
          "Conducted usability testing with over 50 participants",
          "Implemented design process improvements that reduced iteration cycles"
        ]
      },
      %{
        company: "Creative Agency",
        title: "UI Designer",
        period: "2016 - 2018",
        description: "Created visual designs and interactive prototypes for various client projects. Worked closely with development teams to ensure design implementation fidelity.",
        achievements: [
          "Designed interfaces for 15+ client projects across different industries",
          "Developed the agency's first comprehensive UI component library",
          "Contributed to two award-winning website designs"
        ]
      }
    ]

    education = [
      %{
        institution: "University of Design",
        degree: "Master of Human-Computer Interaction",
        period: "2014 - 2016",
        description: "Focused on user research methods, information architecture, and interaction design. Thesis project on designing accessible interfaces for elderly users."
      },
      %{
        institution: "State University",
        degree: "Bachelor of Arts in Graphic Design",
        period: "2010 - 2014",
        description: "Studied visual design principles, typography, and digital media. Minor in psychology."
      }
    ]

    skills = [
      %{
        category: "Design",
        items: ["User Experience Design", "Visual Design", "Interaction Design", "Information Architecture", "Design Systems", "Responsive Design", "Accessibility"]
      },
      %{
        category: "Research",
        items: ["User Interviews", "Usability Testing", "A/B Testing", "Journey Mapping", "Competitive Analysis", "Survey Design", "Heuristic Evaluation"]
      },
      %{
        category: "Tools",
        items: ["Figma", "Adobe XD", "Sketch", "InVision", "Principle", "Adobe Creative Suite", "Miro"]
      },
      %{
        category: "Development",
        items: ["HTML/CSS", "JavaScript", "React", "Tailwind CSS", "Phoenix LiveView", "Version Control", "Responsive Frameworks"]
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
                    I'm a UX designer and front-end developer based in San Francisco, specializing in creating intuitive digital experiences that solve real user problems.
                  </p>
                  <p class="text-gray-600 mb-6">
                    With over 8 years of experience working across various industries, I combine strategic thinking with hands-on design skills to create solutions that are both user-centered and business-aligned. I believe in the power of design to transform complex challenges into simple, elegant solutions.
                  </p>
                  <p class="text-gray-600 mb-6">
                    When I'm not designing, you can find me hiking in the Bay Area, experimenting with new coding frameworks, or attending local design meetups to stay connected with the community.
                  </p>
                </div>
                <div id="about-photo" phx-hook="FadeIn">
                  <img src="/images/profile.jpg" alt="Brian H." class="w-full h-auto rounded-sm shadow-sm" />
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

          <.main_nav active={@active} />
        </div>
      </main>

      <.mobile_menu active={@active} show_menu={@show_menu} />
    </div>
    """
  end
end
