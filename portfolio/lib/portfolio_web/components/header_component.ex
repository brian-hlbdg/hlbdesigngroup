# lib/portfolio_web/components/header_component.ex
defmodule PortfolioWeb.HeaderComponent do
  use PortfolioWeb, :html

  def status_bar(assigns) do
    ~H"""
    <header class="w-full px-8 md:px-12 pt-4 pb-2 border-b border-gray-100 bg-white fixed top-0 z-40">
      <div class="flex justify-between items-center">
        <div class="flex items-center">
          <span id="datetime" phx-hook="UpdateTime" class="text-sm text-gray-500">
            <%= @current_time %>
          </span>
          <span class="text-sm text-gray-500 ml-2 hidden md:inline">Chicago, IL</span>
        </div>
        <div class="flex items-center">
          <span class="text-sm mr-6">Brian H.</span>
          <button
            class="text-sm text-gray-600 hover:text-[rgb(211,84,0)] transition-colors md:hidden"
            phx-click="toggle_menu">
            Menu
          </button>
        </div>
      </div>
    </header>
    """
  end
end
