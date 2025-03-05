# lib/portfolio_web/live/home_live.ex
defmodule PortfolioWeb.HomeLive do
  use PortfolioWeb.BaseLive

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> mount_common("home")
      |> assign(:page_title, "Portfolio")
    }
  end

  def render(assigns) do
    ~H"""
    <div id="home-page-container" phx-hook="PageTransition" class="min-h-screen bg-white dark:bg-dark max-w-full overflow-hidden">
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
            </div>
          </div>

          <div class="hidden md:block">
            <.main_nav active={@active} />
          </div>
        </div>
      </main>

      <div class="w-full fixed bottom-0 md:hidden">
        <nav class="flex justify-around py-4 bg-white dark:bg-dark-surface border-t border-gray-200 dark:border-gray-800">
          <.link navigate={~p"/"} class="text-xs text-primary dark:text-primary-dark flex flex-col items-center">
            <span class="material-icons text-lg">home</span>
            <span>Home</span>
          </.link>
          <.link navigate={~p"/projects"} class="text-xs text-gray-500 dark:text-gray-400 flex flex-col items-center">
            <span class="material-icons text-lg">work</span>
            <span>Work</span>
          </.link>
          <.link navigate={~p"/process"} class="text-xs text-gray-500 dark:text-gray-400 flex flex-col items-center">
            <span class="material-icons text-lg">insights</span>
            <span>Process</span>
          </.link>
          <.link navigate={~p"/hobbies"} class="text-xs text-gray-500 dark:text-gray-400 flex flex-col items-center">
            <span class="material-icons text-lg">camera_alt</span>
            <span>Hobbies</span>
          </.link>
          <.link navigate={~p"/about"} class="text-xs text-gray-500 dark:text-gray-400 flex flex-col items-center">
            <span class="material-icons text-lg">person</span>
            <span>About</span>
          </.link>
        </nav>
      </div>

      <.mobile_menu active={@active} show_menu={@show_menu} />
    </div>
    """
  end
end
