defmodule PortfolioWeb.BaseLive do
  defmacro __using__(_opts) do
    quote do
      use PortfolioWeb, :live_view
      import PortfolioWeb.NavComponent
      import PortfolioWeb.HeaderComponent

      def mount_common(socket, page_name) do
        # Get theme from session if available, or use default
        theme = case get_connect_params(socket) do
          %{"theme" => theme} when theme in ["light", "dark"] -> theme
          _ -> "light" # Default theme
        end

        socket
        |> assign(:current_time, Calendar.strftime(DateTime.utc_now(), "%A, %B %d, %Y at %I:%M:%S %p"))
        |> assign(:show_menu, false)
        |> assign(:active, page_name)
        |> assign(:scroll_positions, %{})
        |> assign(:theme, theme)
        |> push_event("toggle-theme", %{theme: theme}) # Ensure client-side is in sync
      end

      # Common event handlers for all LiveViews
      def handle_event("toggle_menu", _, socket) do
        # Toggle menu visibility without re-initializing the page
        {:noreply, update(socket, :show_menu, fn show -> !show end)}
      end

      def handle_event("toggle_theme", _, socket) do
        new_theme = if socket.assigns.theme == "light", do: "dark", else: "light"

        # Push the theme change to the client to update localStorage
        push_event(socket, "toggle-theme", %{theme: new_theme})

        {:noreply, assign(socket, :theme, new_theme)}
      end

      # Handle page loading for scroll restoration
      def handle_event("store_scroll", %{"path" => path, "position" => position}, socket) do
        scroll_positions = Map.put(socket.assigns.scroll_positions, path, position)
        {:noreply, assign(socket, scroll_positions: scroll_positions)}
      end

      # Handle navigation through the mobile menu
      def handle_params(_params, _uri, socket) do
        # If a user navigates, we want to close the mobile menu
        {:noreply, assign(socket, show_menu: false)}
      end

      # Make sure to preserve existing state in handle_info
      def handle_info(:toggle_menu, socket) do
        {:noreply, update(socket, :show_menu, fn show -> !show end)}
      end
    end
  end
end
