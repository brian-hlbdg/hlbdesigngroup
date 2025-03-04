# lib/portfolio_web/live/project_live.ex
defmodule PortfolioWeb.ProjectLive do
  use PortfolioWeb.BaseLive

  def mount(_params, _session, socket) do
    projects = [
      %{
        id: "design-system",
        title: "Financial App Design System",
        description: "A comprehensive design system that improved development speed by 40% and ensured consistency across platforms.",
        client: "FinTech Innovations",
        year: "2024",
        tags: ["Design Systems", "UI/UX", "Component Library"],
        thumbnail: "/images/projects/design-system-thumb.jpg",
        featured: true
      },
      %{
        id: "healthcare-portal",
        title: "Healthcare Patient Portal",
        description: "Accessible patient portal that simplified appointment scheduling and medical record access for users of all abilities.",
        client: "MedCare Solutions",
        year: "2023",
        tags: ["Accessibility", "User Research", "Web App"],
        thumbnail: "/images/projects/healthcare-thumb.jpg",
        featured: true
      },
      %{
        id: "ecommerce-mobile",
        title: "E-Commerce Mobile Experience",
        description: "Mobile-first shopping experience that increased conversion rates by 35% through streamlined checkout and personalized recommendations.",
        client: "Urban Retail",
        year: "2023",
        tags: ["Mobile Design", "E-Commerce", "Conversion Optimization"],
        thumbnail: "/images/projects/ecommerce-thumb.jpg",
        featured: false
      },
      %{
        id: "fintech-dashboard",
        title: "Investment Dashboard",
        description: "Data visualization dashboard for tracking investments and financial performance with intuitive controls and actionable insights.",
        client: "Wealth Management Inc.",
        year: "2022",
        tags: ["Data Visualization", "Dashboard Design", "Financial"],
        thumbnail: "/images/projects/dashboard-thumb.jpg",
        featured: false
      },
      %{
        id: "travel-booking",
        title: "Travel Booking Platform",
        description: "End-to-end travel booking experience with immersive photography and streamlined booking flow.",
        client: "Wanderlust Travel",
        year: "2022",
        tags: ["Travel", "Booking System", "UX Design"],
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
    <div id="page-container" phx-hook="PageTransition" class="min-h-screen bg-white dark:bg-gray-900 transition-colors duration-300">
      <main>
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%]">
            <div>
              <h1 id="work-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-8 text-gray-900 dark:text-white transition-colors" phx-hook="FadeIn">
                Selected Work
              </h1>

              <div id="featured-work" class="mt-16" phx-hook="FadeIn">
                <h2 class="text-2xl font-light mb-6 text-gray-800 dark:text-gray-200 transition-colors">Featured Projects</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-16">
                  <%= for project <- Enum.filter(@projects, & &1.featured) do %>
                    <div class="project-card border-t border-gray-200 dark:border-gray-700 pt-6 transition-colors" id={"project-#{project.id}"} phx-hook="ImageHover">
                      <div class="overflow-hidden mb-4 bg-gray-100 dark:bg-gray-800 transition-colors">
                        <img src={project.thumbnail} alt={project.title} class="w-full h-auto object-cover transition-transform hover:scale-105 duration-500" />
                      </div>
                      <div class="flex flex-col space-y-2">
                        <h3 class="text-xl font-medium text-gray-900 dark:text-white transition-colors"><%= project.title %></h3>
                        <p class="text-gray-600 dark:text-gray-300 transition-colors"><%= project.description %></p>
                        <div class="flex justify-between items-center mt-4">
                          <div class="text-sm text-gray-500 dark:text-gray-400 transition-colors"><%= project.client %>, <%= project.year %></div>
                          <.link navigate={~p"/projects/#{project.id}"} class="text-sm text-gray-600 dark:text-gray-300 hover:text-primary dark:hover:text-primary transition-colors group inline-flex items-center">
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
                <h2 class="text-2xl font-light mb-6 text-gray-800 dark:text-gray-200 transition-colors">Additional Projects</h2>
                <div class="divide-y divide-gray-200 dark:divide-gray-700 transition-colors">
                  <%= for project <- Enum.filter(@projects, & !&1.featured) do %>
                    <div class="project-item py-6" id={"project-list-#{project.id}"}>
                      <div class="flex flex-col md:flex-row md:items-center md:justify-between">
                        <div class="md:w-2/3">
                          <h3 class="text-xl font-medium mb-2 text-gray-900 dark:text-white transition-colors"><%= project.title %></h3>
                          <p class="text-gray-600 dark:text-gray-300 mb-4 md:mb-0 transition-colors"><%= project.description %></p>
                        </div>
                        <div class="flex flex-col md:items-end">
                          <div class="text-sm text-gray-500 dark:text-gray-400 mb-2 transition-colors"><%= project.client %>, <%= project.year %></div>
                          <.link navigate={~p"/projects/#{project.id}"} class="text-sm text-gray-600 dark:text-gray-300 hover:text-primary dark:hover:text-primary transition-colors group inline-flex items-center">
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
