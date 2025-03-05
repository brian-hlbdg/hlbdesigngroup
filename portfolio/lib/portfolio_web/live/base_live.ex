# lib/portfolio_web/live/base_live.ex
defmodule PortfolioWeb.BaseLive do
  defmacro __using__(_opts) do
    quote do
      use PortfolioWeb, :live_view
      import PortfolioWeb.NavComponent
      import PortfolioWeb.HeaderComponent

      def mount_common(socket, page_name) do
        socket
        |> assign(:current_time, Calendar.strftime(DateTime.utc_now(), "%A, %B %d, %Y at %I:%M:%S %p"))
        |> assign(:show_menu, false)
        |> assign(:active, page_name)
        |> assign(:scroll_positions, %{})
        |> assign(:theme, get_theme_from_session())
      end

      # Get theme from session or default to system preference
      defp get_theme_from_session do
        # In a real app, this would come from the user's session
        # For now, we'll default to "light"
        "light"
      end

      # Common event handlers for all LiveViews
      def handle_event("toggle_menu", _, socket) do
        # Toggle menu visibility without re-initializing the page
        {:noreply, update(socket, :show_menu, fn show -> !show end)}
      end

      # Handle theme changes
      def handle_event("theme-changed", %{"theme" => theme}, socket) do
        # In a real app, you could save this to the user's session/profile
        {:noreply, assign(socket, :theme, theme)}
      end

      # Handle navigation through the mobile menu
      def handle_params(_params, _uri, socket) do
        # If a user navigates, we want to close the mobile menu
        {:noreply, assign(socket, show_menu: false)}
      end

      def handle_event("store_scroll", %{"path" => path, "position" => position}, socket) do
        scroll_positions = Map.put(socket.assigns.scroll_positions, path, position)
        {:noreply, assign(socket, scroll_positions: scroll_positions)}
      end

      # Make sure to preserve existing state in handle_info
      def handle_info(:toggle_menu, socket) do
        {:noreply, update(socket, :show_menu, fn show -> !show end)}
      end
    end
  end
end
