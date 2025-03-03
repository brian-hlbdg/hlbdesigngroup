# lib/portfolio_web/live/project_detail_live.ex
defmodule PortfolioWeb.ProjectDetailLive do
  use PortfolioWeb.BaseLive

  def mount(%{"id" => project_id}, _session, socket) do
    # In a real app, this would come from a database
    project = get_project_by_id(project_id)

    {:ok,
      socket
      |> mount_common("work") # Keep the work section highlighted in nav
      |> assign(:page_title, project.title)
      |> assign(:project, project)
    }
  end

  def render(assigns) do
    ~H"""
    <div id="page-container" phx-hook="PageTransition" class="min-h-screen bg-white">
      <main>
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%]">
            <div id="project-detail" phx-hook="FadeIn">
              <div class="mb-6">
                <.link navigate={~p"/projects"} class="text-sm text-gray-600 hover:text-[rgb(211,84,0)] transition-colors group inline-flex items-center">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1 group-hover:-translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                  </svg>
                  Back to Work
                </.link>
              </div>

              <h1 id="project-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-4">
                <%= @project.title %>
              </h1>

              <div class="text-gray-600 mb-8">
                <%= @project.client %>, <%= @project.year %>
              </div>

              <div class="mb-12">
                <img src={@project.hero_image} alt={@project.title} class="w-full h-auto" />
              </div>

              <div class="project-content max-w-3xl">
                <section class="mb-12">
                  <h2 class="text-2xl font-light mb-4">Overview</h2>
                  <p class="text-gray-700 mb-4"><%= @project.overview %></p>
                </section>

                <section class="mb-12">
                  <h2 class="text-2xl font-light mb-4">Challenge</h2>
                  <p class="text-gray-700 mb-4"><%= @project.challenge %></p>
                </section>

                <section class="mb-12">
                  <h2 class="text-2xl font-light mb-4">Process</h2>
                  <p class="text-gray-700 mb-4"><%= @project.process %></p>

                  <%= if @project.process_images do %>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-8">
                      <%= for {image, index} <- Enum.with_index(@project.process_images) do %>
                        <div>
                          <img src={image} alt={"Process image #{index + 1}"} class="w-full h-auto mb-2" />
                          <%= if @project.process_captions && Enum.at(@project.process_captions, index) do %>
                            <p class="text-sm text-gray-500"><%= Enum.at(@project.process_captions, index) %></p>
                          <% end %>
                        </div>
                      <% end %>
                    </div>
                  <% end %>
                </section>

                <section class="mb-12">
                  <h2 class="text-2xl font-light mb-4">Solution</h2>
                  <p class="text-gray-700 mb-4"><%= @project.solution %></p>

                  <%= if @project.solution_images do %>
                    <div class="mt-8">
                      <%= for {image, index} <- Enum.with_index(@project.solution_images) do %>
                        <div class="mb-8">
                          <img src={image} alt={"Solution image #{index + 1}"} class="w-full h-auto mb-2" />
                          <%= if @project.solution_captions && Enum.at(@project.solution_captions, index) do %>
                            <p class="text-sm text-gray-500"><%= Enum.at(@project.solution_captions, index) %></p>
                          <% end %>
                        </div>
                      <% end %>
                    </div>
                  <% end %>
                </section>

                <section class="mb-12">
                  <h2 class="text-2xl font-light mb-4">Results</h2>
                  <p class="text-gray-700 mb-4"><%= @project.results %></p>

                  <%= if @project.results_metrics do %>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8">
                      <%= for metric <- @project.results_metrics do %>
                        <div class="border-t border-gray-200 pt-4">
                          <div class="text-3xl font-medium mb-2"><%= metric.value %></div>
                          <div class="text-gray-600"><%= metric.label %></div>
                        </div>
                      <% end %>
                    </div>
                  <% end %>
                </section>

                <%= if @project.testimonial do %>
                  <section class="mb-12 border-l-4 border-gray-200 pl-6 py-2">
                    <blockquote class="text-xl text-gray-700 italic mb-4">
                      "<%= @project.testimonial.quote %>"
                    </blockquote>
                    <div class="text-gray-600">
                      — <%= @project.testimonial.author %>, <%= @project.testimonial.role %>
                    </div>
                  </section>
                <% end %>

                <section class="mb-12">
                  <h2 class="text-2xl font-light mb-4">Next Steps</h2>
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mt-8">
                    <%= if @project.prev_project do %>
                      <.link navigate={~p"/projects/#{@project.prev_project.id}"} class="group">
                        <div class="border-t border-gray-200 pt-4">
                          <div class="text-sm text-gray-500 mb-2">Previous Project</div>
                          <div class="text-xl group-hover:text-[rgb(211,84,0)] transition-colors flex items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2 group-hover:-translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                            </svg>
                            <%= @project.prev_project.title %>
                          </div>
                        </div>
                      </.link>
                    <% end %>

                    <%= if @project.next_project do %>
                      <.link navigate={~p"/projects/#{@project.next_project.id}"} class="group md:text-right">
                        <div class="border-t border-gray-200 pt-4">
                          <div class="text-sm text-gray-500 mb-2">Next Project</div>
                          <div class="text-xl group-hover:text-[rgb(211,84,0)] transition-colors flex items-center md:justify-end">
                            <%= @project.next_project.title %>
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-2 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                            </svg>
                          </div>
                        </div>
                      </.link>
                    <% end %>
                  </div>
                </section>
              </div>
            </div>
          </div>

          <div class="w-full md:w-48 pt-12 md:pt-24">
            <div class="md:sticky md:top-24">
              <.main_nav active={@active} />

              <div class="hidden md:block mt-12 border-t border-gray-200 pt-6">
                <h3 class="text-sm text-gray-500 mb-4">Project Details</h3>

                <div class="mb-4">
                  <div class="text-xs text-gray-500 mb-1">Client</div>
                  <div class="text-sm"><%= @project.client %></div>
                </div>

                <div class="mb-4">
                  <div class="text-xs text-gray-500 mb-1">Timeline</div>
                  <div class="text-sm"><%= @project.timeline %></div>
                </div>

                <div class="mb-4">
                  <div class="text-xs text-gray-500 mb-1">My Role</div>
                  <div class="text-sm"><%= @project.role %></div>
                </div>

                <div class="mb-4">
                  <div class="text-xs text-gray-500 mb-1">Team</div>
                  <div class="text-sm"><%= @project.team %></div>
                </div>

                <div class="mb-4">
                  <div class="text-xs text-gray-500 mb-1">Categories</div>
                  <div class="flex flex-wrap gap-2 mt-1">
                    <%= for tag <- @project.tags do %>
                      <span class="text-xs px-2 py-1 bg-gray-100 rounded-full"><%= tag %></span>
                    <% end %>
                  </div>
                </div>

                <%= if @project.live_url do %>
                  <div class="mt-6">
                    <a href={@project.live_url} target="_blank" rel="noopener noreferrer" class="text-sm text-gray-600 hover:text-[rgb(211,84,0)] transition-colors group inline-flex items-center">
                      View Live Site
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                      </svg>
                    </a>
                  </div>
                <% end %>
              </div>
            </div>
          </div>
        </div>
      </main>

      <.mobile_menu active={@active} show_menu={@show_menu} />
    </div>
    """
  end

  # Mock function to get project data
  # In a real app, this would fetch from a database
  defp get_project_by_id(project_id) do
    all_projects = %{
      "ecommerce-mobile" => %{
        id: "ecommerce-mobile",
        title: "E-Commerce Mobile Experience",
        description: "Mobile-first shopping experience that increased conversion rates by 35% through streamlined checkout and personalized recommendations.",
        client: "Urban Retail",
        year: "2023",
        timeline: "March 2023 - July 2023",
        role: "UX/UI Designer",
        team: "1 Product Manager, 2 Developers, 1 Marketing Specialist",
        tags: ["Mobile Design", "E-Commerce", "Conversion Optimization"],
        thumbnail: "/images/projects/ecommerce-thumb.jpg",
        hero_image: "/images/projects/ecommerce-hero.jpg",
        overview: "Urban Retail needed to reimagine their mobile shopping experience to address declining conversion rates and high cart abandonment. The project focused on creating an engaging, frictionless mobile shopping journey optimized for conversion.",
        challenge: "The client's existing mobile experience was essentially a scaled-down version of their desktop site, resulting in poor usability, slow load times, and a complicated checkout process. Mobile conversion rates were 40% lower than desktop, despite mobile traffic accounting for 65% of total visitors.",
        process: "I conducted a comprehensive competitive analysis of top e-commerce apps, followed by user interviews and usability testing of the existing mobile experience. Working closely with the marketing team, we analyzed customer journey data to identify key drop-off points and opportunities. I created multiple design concepts focused on simplifying the purchase journey.",
        process_images: [
          "/images/projects/ecommerce-process-1.jpg",
          "/images/projects/ecommerce-process-2.jpg"
        ],
        process_captions: [
          "Customer journey analysis",
          "Mobile checkout usability testing"
        ],
        solution: "The redesigned mobile experience featured a streamlined product browsing interface with gesture-based interactions, a simplified two-step checkout process, and personalized product recommendations. We implemented a persistent cart, saved payment options, and intelligent form design to reduce friction throughout the purchasing flow.",
        solution_images: [
          "/images/projects/ecommerce-solution-1.jpg",
          "/images/projects/ecommerce-solution-2.jpg"
        ],
        solution_captions: [
          "Redesigned product browsing experience",
          "Streamlined checkout process"
        ],
        results: "Within three months of launch, mobile conversion rates increased by 35%, cart abandonment decreased by 28%, and average order value improved by 15%. The time spent completing checkout decreased by 40%, and customer satisfaction scores for the mobile experience increased significantly.",
        results_metrics: [
          %{value: "35%", label: "Increase in conversion rate"},
          %{value: "28%", label: "Decrease in cart abandonment"},
          %{value: "15%", label: "Increase in average order value"}
        ],
        testimonial: %{
          quote: "The new mobile experience has completely transformed our business. It's so much easier to use that we're seeing customers make repeat purchases at a rate we've never experienced before.",
          author: "Maya Rodriguez",
          role: "Digital Director at Urban Retail"
        },
        live_url: "https://example.com/urban-retail-app",
        featured: false,
        prev_project: %{
          id: "healthcare-portal",
          title: "Healthcare Patient Portal"
        },
        next_project: %{
          id: "fintech-dashboard",
          title: "Investment Dashboard"
        }
      },

      "fintech-dashboard" => %{
        id: "fintech-dashboard",
        title: "Investment Dashboard",
        description: "Data visualization dashboard for tracking investments and financial performance with intuitive controls and actionable insights.",
        client: "Wealth Management Inc.",
        year: "2022",
        timeline: "August 2022 - December 2022",
        role: "Data Visualization Designer",
        team: "1 Product Manager, 2 Developers, 1 Data Scientist",
        tags: ["Data Visualization", "Dashboard Design", "Financial"],
        thumbnail: "/images/projects/dashboard-thumb.jpg",
        hero_image: "/images/projects/dashboard-hero.jpg",
        overview: "Wealth Management Inc. needed a sophisticated yet intuitive dashboard that would help their clients understand complex investment data and portfolio performance at a glance, while providing powerful tools for detailed analysis.",
        challenge: "The client's existing reporting system was outdated, providing static monthly reports that were difficult to understand and lacked interactivity. Clients were overwhelmed by complex financial data and struggled to make informed decisions about their investments.",
        process: "I collaborated with financial advisors and data scientists to understand the critical metrics and relationships in the data. Through card sorting exercises with clients, we prioritized information needs and mental models. I created multiple visualization prototypes and tested them with users to ensure clarity and utility.",
        process_images: [
          "/images/projects/dashboard-process-1.jpg",
          "/images/projects/dashboard-process-2.jpg"
        ],
        process_captions: [
          "Information architecture and data mapping",
          "Visualization prototype testing"
        ],
        solution: "The final dashboard featured a customizable overview with key performance indicators, interactive charts for exploring portfolio allocation and performance trends, and scenario modeling tools. We designed intuitive filtering controls and implemented progressive disclosure to manage complexity while providing depth when needed.",
        solution_images: [
          "/images/projects/dashboard-solution-1.jpg",
          "/images/projects/dashboard-solution-2.jpg"
        ],
        solution_captions: [
          "Portfolio performance visualization",
          "Interactive asset allocation view"
        ],
        results: "Client engagement with financial data increased by 200%, while time spent understanding investment performance decreased by 45%. Financial advisors reported a 60% reduction in clarification questions from clients, and overall client satisfaction with transparency increased significantly.",
        results_metrics: [
          %{value: "200%", label: "Increase in data engagement"},
          %{value: "45%", label: "Decrease in comprehension time"},
          %{value: "60%", label: "Reduction in support questions"}
        ],
        testimonial: %{
          quote: "This dashboard has transformed how I interact with my investments. I can finally see exactly what's happening with my money and make decisions based on clear information.",
          author: "Daniel Lawson",
          role: "Client at Wealth Management Inc."
        },
        live_url: "https://example.com/wealth-dashboard",
        featured: false,
        prev_project: %{
          id: "ecommerce-mobile",
          title: "E-Commerce Mobile Experience"
        },
        next_project: %{
          id: "travel-booking",
          title: "Travel Booking Platform"
        }
      },

      "travel-booking" => %{
        id: "travel-booking",
        title: "Travel Booking Platform",
        description: "End-to-end travel booking experience with immersive photography and streamlined booking flow.",
        client: "Wanderlust Travel",
        year: "2022",
        timeline: "February 2022 - June 2022",
        role: "UX Designer",
        team: "1 Product Manager, 3 Developers, 1 Content Strategist",
        tags: ["Travel", "Booking System", "UX Design"],
        thumbnail: "/images/projects/travel-thumb.jpg",
        hero_image: "/images/projects/travel-hero.jpg",
        overview: "Wanderlust Travel wanted to reinvent their booking experience to focus on inspiration and discovery, while streamlining the actual booking process to remove common pain points and increase conversion rates.",
        challenge: "The existing booking platform was functional but uninspiring, with a focus on dates and prices rather than destinations and experiences. The booking flow was cumbersome, requiring numerous steps and form fields, leading to high abandonment rates especially on mobile devices.",
        process: "I conducted extensive user research to understand the emotional and practical aspects of travel planning. Through journey mapping exercises, we identified key moments of inspiration and friction. I created a content strategy focused on immersive photography and authentic destination information, paired with a simplified booking experience.",
        process_images: [
          "/images/projects/travel-process-1.jpg",
          "/images/projects/travel-process-2.jpg"
        ],
        process_captions: [
          "Travel planning journey map",
          "Booking flow wireframes"
        ],
        solution: "The redesigned platform featured large, immersive destination photography, curated travel stories, and contextual recommendations. We implemented a progressive booking flow that remembered user preferences and simplified form completion. The mobile experience was completely redesigned for on-the-go booking.",
        solution_images: [
          "/images/projects/travel-solution-1.jpg",
          "/images/projects/travel-solution-2.jpg"
        ],
        solution_captions: [
          "Destination discovery experience",
          "Streamlined mobile booking flow"
        ],
        results: "Conversion rates increased by 45%, time spent exploring destinations increased by 120%, and booking abandonment decreased by 35%. The platform saw a 60% increase in mobile bookings and significant improvement in customer satisfaction scores.",
        results_metrics: [
          %{value: "45%", label: "Increase in conversion rate"},
          %{value: "120%", label: "Increase in destination exploration"},
          %{value: "60%", label: "Increase in mobile bookings"}
        ],
        testimonial: %{
          quote: "The new platform doesn't just help me book travel, it inspires me to explore places I never would have considered. Then when I'm ready to book, it's incredibly easy.",
          author: "Emma Sinclair",
          role: "Wanderlust Travel Customer"
        },
        live_url: "https://example.com/wanderlust",
        featured: false,
        prev_project: %{
          id: "fintech-dashboard",
          title: "Investment Dashboard"
        },
        next_project: %{
          id: "design-system",
          title: "Financial App Design System"
        }
      },
      "design-system" => %{
        id: "design-system",
        title: "Financial App Design System",
        description: "A comprehensive design system that improved development speed by 40% and ensured consistency across platforms.",
        client: "FinTech Innovations",
        year: "2024",
        timeline: "January 2024 - April 2024",
        role: "Lead UX Designer",
        team: "1 Product Manager, 2 Developers",
        tags: ["Design Systems", "UI/UX", "Component Library"],
        thumbnail: "/images/projects/design-system-thumb.jpg",
        hero_image: "/images/projects/design-system-hero.jpg",
        overview: "FinTech Innovations needed a comprehensive design system to ensure consistency across their growing suite of financial products while increasing development efficiency. I led the design efforts to create a cohesive system that would scale with their expanding product line.",
        challenge: "The application had grown organically over several years, resulting in inconsistent UI elements, redundant code, and a fragmented user experience across web and mobile platforms. The development team was spending excessive time reimplementing similar components, and users were confused by the inconsistent interfaces.",
        process: "I began with a comprehensive audit of all UI elements across the product ecosystem, documenting inconsistencies and identifying patterns. Working closely with developers and stakeholders, I established design principles and component requirements. Through iterative design sprints, we developed and tested core components before expanding to more complex patterns.",
        process_images: [
          "/images/projects/design-system-process-1.jpg",
          "/images/projects/design-system-process-2.jpg"
        ],
        process_captions: [
          "Component audit and inventory",
          "Design pattern documentation"
        ],
        solution: "The final design system included a comprehensive Figma component library with coded counterparts, detailed documentation, usage guidelines, and accessibility standards. We implemented a version control system for the design assets and established governance processes for maintaining and evolving the system.",
        solution_images: [
          "/images/projects/design-system-solution-1.jpg",
          "/images/projects/design-system-solution-2.jpg"
        ],
        solution_captions: [
          "Component library organization",
          "Pattern implementation examples"
        ],
        results: "After implementing the design system, development velocity increased by 40%, design consistency improved across all platforms, and user satisfaction scores rose by 25%. The system has become a central resource for the organization and continues to evolve as new products are developed.",
        results_metrics: [
          %{value: "40%", label: "Faster development time"},
          %{value: "25%", label: "Increase in user satisfaction"},
          %{value: "60%", label: "Reduction in design inconsistencies"}
        ],
        testimonial: %{
          quote: "The design system has completely transformed how we build products. What used to take weeks now takes days, and everything looks and feels cohesive.",
          author: "Sarah Johnson",
          role: "CTO at FinTech Innovations"
        },
        live_url: "https://example.com/fintech-design-system",
        featured: true,
        prev_project: %{
          id: "travel-booking",
          title: "Travel Booking Platform"
        },
        next_project: %{
          id: "healthcare-portal",
          title: "Healthcare Patient Portal"
        }
      },

      "healthcare-portal" => %{
        id: "healthcare-portal",
        title: "Healthcare Patient Portal",
        description: "Accessible patient portal that simplified appointment scheduling and medical record access for users of all abilities.",
        client: "MedCare Solutions",
        year: "2023",
        timeline: "June 2023 - November 2023",
        role: "UX Designer & Accessibility Specialist",
        team: "1 Product Manager, 3 Developers, 1 QA",
        tags: ["Accessibility", "User Research", "Web App"],
        thumbnail: "/images/projects/healthcare-thumb.jpg",
        hero_image: "/images/projects/healthcare-hero.jpg",
        overview: "MedCare Solutions needed to redesign their patient portal to improve accessibility and simplify critical healthcare tasks. The goal was to create an intuitive interface that would work for users of all abilities, including elderly patients and those with disabilities.",
        challenge: "The existing portal was difficult to navigate, especially for users with limited technical skills or accessibility needs. Patients struggled to complete essential tasks like scheduling appointments, accessing medical records, and communicating with healthcare providers. This led to increased call center volume and patient frustration.",
        process: "I started with comprehensive user research, including interviews with patients across different age groups and ability levels. I conducted accessibility audits of the existing system and created inclusive personas to guide our design decisions. Through collaborative workshops with patients and healthcare providers, we identified key pain points and opportunities for improvement.",
        process_images: [
          "/images/projects/healthcare-process-1.jpg",
          "/images/projects/healthcare-process-2.jpg"
        ],
        process_captions: [
          "Accessibility audit findings",
          "User journey mapping workshop"
        ],
        solution: "The redesigned portal featured a simplified information architecture, clear navigation paths, and thoughtful accessibility features. We implemented high-contrast options, keyboard navigation, screen reader compatibility, and simplified language. The appointment booking flow was completely reimagined with fewer steps and clearer confirmation messages.",
        solution_images: [
          "/images/projects/healthcare-solution-1.jpg",
          "/images/projects/healthcare-solution-2.jpg"
        ],
        solution_captions: [
          "Redesigned appointment booking flow",
          "Accessible medical records interface"
        ],
        results: "The new portal achieved WCAG 2.1 AA compliance and saw a 65% increase in patient portal usage. Call center inquiries decreased by 40%, and patient satisfaction scores improved by 35%. Most importantly, portal usage among elderly patients increased by 70%.",
        results_metrics: [
          %{value: "65%", label: "Increase in portal usage"},
          %{value: "40%", label: "Decrease in support calls"},
          %{value: "70%", label: "Increase in elderly patient engagement"}
        ],
        testimonial: %{
          quote: "For the first time, I can actually manage my healthcare online without having to call my daughter for help. Everything is clear and I can find what I need.",
          author: "Robert Chen",
          role: "Patient, 78 years old"
        },
        live_url: "https://example.com/medcare-portal",
        featured: true,
        prev_project: %{
          id: "design-system",
          title: "Financial App Design System"
        },
        next_project: %{
          id: "ecommerce-mobile",
          title: "E-Commerce Mobile Experience"
        }
      }
    }

    Map.get(all_projects, project_id)
  end
end
