# lib/portfolio_web/live/home_live.ex
defmodule PortfolioWeb.HomeLive do
  use PortfolioWeb.BaseLive

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> mount_common("home")
      |> assign(:page_title, "Brian H. - Portfolio")
    }
  end

  def render(assigns) do
    ~H"""
    <div id="home-page-container" phx-hook="PageTransition" class="min-h-screen bg-white dark:bg-gray-900 text-gray-900 dark:text-gray-100 max-w-full overflow-hidden transition-colors duration-300">
      <main class="flex-1 overflow-hidden pb-0">
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%] border-none">
            <div>
              <h1 id="main-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-8 text-gray-900 dark:text-white" phx-hook="FadeIn">
                I help companies build exceptional digital experiences through thoughtful design.
              </h1>
              <p id="intro-text" class="text-xl md:text-2xl text-gray-600 dark:text-gray-300 max-w-prose mt-8" phx-hook="TypeWriter">
                UX Designer and Front-end Developer focused on creating intuitive,
                user-centered solutions that drive business growth.
              </p>

              <div class="mt-12 pt-8 border-t border-gray-100 animate-fade-in">
                <h2 class="text-2xl font-light mb-6">Featured Projects</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                  <div id="project-card-1" class="project-card group" phx-hook="ImageHover">
                    <.link navigate={~p"/projects/design-system"}>
                      <div class="overflow-hidden mb-4 rounded-sm">
                        <img src="/images/projects/design-system-thumb.jpg" alt="Financial App Design System" class="w-full h-auto object-cover transition-transform" />
                      </div>
                      <h3 class="text-xl font-medium mb-2 group-hover:text-primary transition-colors">Financial App Design System</h3>
                      <p class="text-gray-600 text-sm mb-4">A comprehensive design system that improved development speed by 40% and ensured consistency across platforms.</p>
                    </.link>
                  </div>

                  <div id="project-card-2" class="project-card group" phx-hook="ImageHover">
                    <.link navigate={~p"/projects/healthcare-portal"}>
                      <div class="overflow-hidden mb-4 rounded-sm">
                        <img src="/images/projects/healthcare-thumb.jpg" alt="Healthcare Patient Portal" class="w-full h-auto object-cover transition-transform" />
                      </div>
                      <h3 class="text-xl font-medium mb-2 group-hover:text-primary transition-colors">Healthcare Patient Portal</h3>
                      <p class="text-gray-600 text-sm mb-4">Accessible patient portal that simplified appointment scheduling and medical record access for users of all abilities.</p>
                    </.link>
                  </div>
                </div>

                <div class="mt-8">
                  <.link navigate={~p"/projects"} class="inline-flex items-center text-gray-600 hover:text-primary transition-colors group">
                    View all projects
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                    </svg>
                  </.link>
                </div>
              </div>
            </div>
          </div>

          <div class="hidden md:block">
            <.main_nav active={@active} />
          </div>
        </div>
      </main>



      <.mobile_menu active={@active} show_menu={@show_menu} />
    </div>
    """
  end
end
