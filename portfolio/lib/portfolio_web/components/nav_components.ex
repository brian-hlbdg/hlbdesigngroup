  defmodule PortfolioWeb.NavComponent do
    use PortfolioWeb, :html

    def main_nav(assigns) do
      ~H"""
      <div class="w-full md:w-48 pt-12 md:pt-24">
        <nav id="main-nav" class="flex md:flex-col space-y-0 md:space-y-4 space-x-4 md:space-x-0 mt-8 md:mt-0 opacity-100">
          <.link navigate={~p"/"} class={nav_link_class(@active == "home")}>Home</.link>
          <.link navigate={~p"/projects"} class={nav_link_class(@active == "work")}>Work</.link>
          <.link navigate={~p"/process"} class={nav_link_class(@active == "process")}>Process</.link>
          <.link navigate={~p"/about"} class={nav_link_class(@active == "about")}>About</.link>
          <.link navigate={~p"/hobbies"} class={nav_link_class(@active == "hobbies")}>Hobbies</.link>
          <.link navigate={~p"/contact"} class={nav_link_class(@active == "contact")}>Contact</.link>
        </nav>
      </div>
      """
    end

    def mobile_menu(assigns) do
      ~H"""
      <div class={"fixed inset-0 bg-white z-50 mt-12 flex items-center justify-center transition-opacity duration-300 " <> if @show_menu, do: "opacity-100", else: "opacity-0 pointer-events-none"}>
        <button
          class="absolute top-8 right-8 text-gray-600 text-sm hover:text-primary transition-colors"
          phx-click="toggle_menu">
          Close
        </button>
        <nav class="flex flex-col items-center space-y-6">
          <.link navigate={~p"/"} class={mobile_link_class(@active == "home")} phx-click="toggle_menu">Home</.link>
          <.link navigate={~p"/projects"} class={mobile_link_class(@active == "work")} phx-click="toggle_menu">Work</.link>
          <.link navigate={~p"/process"} class={mobile_link_class(@active == "process")} phx-click="toggle_menu">Process</.link>
          <.link navigate={~p"/about"} class={mobile_link_class(@active == "about")} phx-click="toggle_menu">About</.link>
          <.link navigate={~p"/hobbies"} class={mobile_link_class(@active == "hobbies")} phx-click="toggle_menu">Hobbies</.link>
          <.link navigate={~p"/contact"} class={mobile_link_class(@active == "contact")} phx-click="toggle_menu">Contact</.link>
        </nav>
      </div>
      """
    end

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
              class="text-sm text-gray-600 hover:text-primary transition-colors md:hidden"
              phx-click="toggle_menu">
              Menu
            </button>
          </div>
        </div>
      </header>
      """
    end

    defp nav_link_class(true), do: "text-primary text-sm font-medium transition-colors"
    defp nav_link_class(false), do: "text-gray-600 text-sm hover:text-primary transition-colors"

    defp mobile_link_class(true), do: "text-primary text-xl font-medium transition-colors"
    defp mobile_link_class(false), do: "text-gray-600 text-xl hover:text-primary transition-colors"
  end
