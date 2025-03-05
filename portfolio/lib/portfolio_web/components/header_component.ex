# lib/portfolio_web/components/header_component.ex
defmodule PortfolioWeb.HeaderComponent do
  use PortfolioWeb, :html

  def status_bar(assigns) do
    ~H"""
    <header class="w-full px-8 md:px-12 pt-4 pb-2 border-b border-gray-100 dark:border-gray-800 bg-white dark:bg-dark fixed top-0 z-40">
      <div class="flex justify-between items-center">
        <div class="flex items-center">
          <span id="datetime" phx-hook="UpdateTime" class="text-sm text-gray-500 dark:text-gray-400">
            <%= @current_time %>
          </span>
          <span class="text-sm text-gray-500 dark:text-gray-400 ml-2 hidden md:inline">Chicago, IL</span>
        </div>
        <div class="flex items-center">
          <span class="text-sm mr-6 dark:text-gray-300">Brian H.</span>

          <!-- Theme toggle button -->
          <button
            id="theme-toggle"
            phx-hook="ThemeToggle"
            class="theme-toggle-btn mr-4"
            aria-label="Toggle dark mode">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 light-icon" viewBox="0 0 20 20" fill="currentColor">
              <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z" />
            </svg>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 dark-icon hidden" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" clip-rule="evenodd" />
            </svg>
          </button>

          <button
            class="text-sm text-gray-600 hover:text-primary transition-colors dark:text-gray-400 dark:hover:text-primary-dark md:hidden"
            phx-click="toggle_menu">
            Menu
          </button>
        </div>
      </div>
    </header>
    """
  end
end
