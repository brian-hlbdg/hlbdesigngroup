# lib/portfolio_web/components/nav_component.ex
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
    <div class={"fixed inset-0 bg-white dark:bg-gray-900 z-50 mt-12 flex items-center justify-center transition-opacity duration-300 " <> if @show_menu, do: "opacity-100", else: "opacity-0 pointer-events-none"}>
      <button
        class="absolute top-8 right-8 text-gray-600 dark:text-gray-400 text-sm hover:text-primary dark:hover:text-primary transition-colors"
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

  defp nav_link_class(true), do: "text-primary dark:text-primary text-sm font-medium"
  defp nav_link_class(false), do: "text-gray-600 dark:text-gray-400 text-sm hover:text-primary dark:hover:text-primary transition-colors"

  defp mobile_link_class(true), do: "text-primary dark:text-primary text-xl font-medium"
  defp mobile_link_class(false), do: "text-gray-600 dark:text-gray-400 text-xl hover:text-primary dark:hover:text-primary transition-colors"
end
