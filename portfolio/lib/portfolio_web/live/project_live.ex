# lib/portfolio_web/live/project_live.ex
defmodule PortfolioWeb.ProjectLive do
  use PortfolioWeb.BaseLive

  def mount(_params, _session, socket) do
    projects = [
      %{
        id: "transportation-management",
        title: "Transportation Management System",
        description: "User-centric redesign of a complex TMS platform using LiveView, Phoenix, and Elixir to create a logical and efficient user workflow.",
        client: "NFI Industries",
        year: "2022",
        tags: ["Phoenix", "LiveView", "UX Design", "Elixir"],
        thumbnail: "/images/projects/design-system-thumb.jpg",
        featured: true
      },
      %{
        id: "investment-platform",
        title: "Investment Firm Website",
        description: "Complete frontend development for a top investment firm, implementing responsive designs and intuitive user interfaces for financial products.",
        client: "Calamos Investments",
        year: "2016",
        tags: ["Bootstrap", "Sitecore CMS", "Responsive Design"],
        thumbnail: "/images/projects/dashboard-thumb.jpg",
        featured: true
      },
      %{
        id: "ecommerce-redesign",
        title: "E-Commerce Platform Redesign",
        description: "Comprehensive UX/UI redesign that improved navigation, streamlined checkout flow, and enhanced product presentation for increased conversions.",
        client: "PMall",
        year: "2011",
        tags: ["E-Commerce", "UI/UX", "Conversion Optimization"],
        thumbnail: "/images/projects/ecommerce-thumb.jpg",
        featured: false
      },
      %{
        id: "marketing-website",
        title: "Marketing Website Refresh",
        description: "Creation and redesign of multiple websites focused on lead generation and customer engagement with clear information architecture.",
        client: "GKIC",
        year: "2013",
        tags: ["Marketing", "Wireframing", "Website Design"],
        thumbnail: "/images/projects/healthcare-thumb.jpg",
        featured: false
      },
      %{
        id: "design-system",
        title: "Component Library & Design System",
        description: "Development of a comprehensive design system to ensure consistency across platforms while improving development speed and efficiency.",
        client: "Cross-Project Initiative",
        year: "2020",
        tags: ["Design Systems", "Component Library", "Documentation"],
        thumbnail: "/images/projects/travel-thumb.jpg",
        featured: false
      }
    ]

    {:ok,
      socket
      |> mount_common("work")
      |> assign(:page_title, "Work")
      |> assign(:projects, projects)
    }
  end

  def render(assigns) do
    ~H"""
    <div id="page-container" phx-hook="PageTransition" class="min-h-screen bg-white">
      <main>
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%]">
            <div>
              <h1 id="work-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-8" phx-hook="FadeIn">
                Selected Work
              </h1>

              <div id="featured-work" class="mt-16" phx-hook="FadeIn">
                <h2 class="text-2xl font-light mb-6">Featured Projects</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-16">
                  <%= for project <- Enum.filter(@projects, & &1.featured) do %>
                    <div class="project-card border-t border-gray-200 pt-6" id={"project-#{project.id}"} phx-hook="ImageHover">
                      <div class="overflow-hidden mb-4">
                        <img src={project.thumbnail} alt={project.title} class="w-full h-auto object-cover transition-transform hover:scale-105 duration-500" />
                      </div>
                      <div class="flex flex-col space-y-2">
                        <h3 class="text-xl font-medium"><%= project.title %></h3>
                        <p class="text-gray-600"><%= project.description %></p>
                        <div class="flex justify-between items-center mt-4">
                          <div class="text-sm text-gray-500"><%= project.client %>, <%= project.year %></div>
                          <.link navigate={~p"/projects/#{project.id}"} class="text-sm text-gray-600 hover:text-[rgb(211,84,0)] transition-colors group inline-flex items-center">
                            View Project
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                            </svg>
                          </.link>
                        </div>
                      </div>
                    </div>
                  <% end %>
                </div>
              </div>

              <div id="other-work" class="mt-16" phx-hook="FadeIn">
                <h2 class="text-2xl font-light mb-6">Additional Projects</h2>
                <div class="divide-y divide-gray-200">
                  <%= for project <- Enum.filter(@projects, & !&1.featured) do %>
                    <div class="project-item py-6" id={"project-list-#{project.id}"}>
                      <div class="flex flex-col md:flex-row md:items-center md:justify-between">
                        <div class="md:w-2/3">
                          <h3 class="text-xl font-medium mb-2"><%= project.title %></h3>
                          <p class="text-gray-600 mb-4 md:mb-0"><%= project.description %></p>
                        </div>
                        <div class="flex flex-col md:items-end">
                          <div class="text-sm text-gray-500 mb-2"><%= project.client %>, <%= project.year %></div>
                          <.link navigate={~p"/projects/#{project.id}"} class="text-sm text-gray-600 hover:text-[rgb(211,84,0)] transition-colors group inline-flex items-center">
                            View Project
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                            </svg>
                          </.link>
                        </div>
                      </div>
                    </div>
                  <% end %>
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
