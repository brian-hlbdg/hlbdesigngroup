# lib/portfolio_web/live/base_live.ex
defmodule PortfolioWeb.BaseLive do
  defmacro __using__(_opts) do
    quote do
      use PortfolioWeb, :live_view
      import PortfolioWeb.NavComponent

      def mount_common(socket, page_name) do
        socket
        |> assign(:current_time, Calendar.strftime(DateTime.utc_now(), "%A, %B %d, %Y at %I:%M:%S %p"))
        |> assign(:show_menu, false)
        |> assign(:active, page_name)
        |> assign(:scroll_positions, %{})
        |> assign(:page_loading, true)
      end

      # Common handlers for all LiveViews
      def handle_event("toggle_menu", _, socket) do
        {:noreply, assign(socket, show_menu: !socket.assigns.show_menu)}
      end

      def handle_event("page_loaded", _, socket) do
        {:noreply, assign(socket, page_loading: false)}
      end

      def handle_event("store_scroll", %{"path" => path, "position" => position}, socket) do
        scroll_positions = Map.put(socket.assigns.scroll_positions, path, position)
        {:noreply, assign(socket, scroll_positions: scroll_positions)}
      end

      # Ensure menu is closed when navigating
      def handle_params(_params, _uri, socket) do
        {:noreply, assign(socket, show_menu: false, page_loading: false)}
      end

      # Toggle menu handler
      def handle_info(:toggle_menu, socket) do
        {:noreply, assign(socket, show_menu: !socket.assigns.show_menu)}
      end
    end
  end
end
