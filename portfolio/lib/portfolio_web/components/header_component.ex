# lib/portfolio_web/components/header_component.ex
defmodule PortfolioWeb.HeaderComponent do
  use PortfolioWeb, :html

  def status_bar(assigns) do
    ~H"""
    <header class="w-full px-8 md:px-12 pt-4 pb-2 border-b border-gray-100 dark:border-gray-800 bg-white dark:bg-gray-900 fixed top-0 z-40 backdrop-blur-sm">
      <div class="flex justify-between items-center">
        <div class="flex items-center">
          <span id="datetime" phx-hook="UpdateTime" class="text-sm text-gray-500 dark:text-gray-400">
            <%= @current_time %>
          </span>
          <span class="text-sm text-gray-500 dark:text-gray-400 ml-2 hidden md:inline">Chicago, IL</span>
        </div>
        <div class="flex items-center">
          <span class="text-sm text-gray-600 dark:text-gray-400 mr-6">Brian H.</span>
          <button
            id="theme-toggle"
            phx-hook="ThemeToggle"
            class="text-sm text-gray-600 dark:text-gray-400 hover:text-primary dark:hover:text-primary transition-colors mr-4">
            <span class="dark-icon hidden dark:inline">☀️</span>
            <span class="light-icon dark:hidden">🌙</span>
          </button>
          <button
            class="text-sm text-gray-600 dark:text-gray-400 hover:text-primary dark:hover:text-primary transition-colors md:hidden"
            phx-click="toggle_menu">
            Menu
          </button>
        </div>
      </div>
    </header>
    """
  end
end
