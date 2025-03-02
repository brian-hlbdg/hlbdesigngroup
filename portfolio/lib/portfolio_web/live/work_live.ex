defmodule PortfolioWeb.WorkLive do
  use PortfolioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket,
      page_title: "Work - Portfolio",
      current_time: Calendar.strftime(DateTime.utc_now(), "%A, %B %d, %Y at %I:%M:%S %p"),
      projects: [
        %{
          title: "E-Commerce Redesign",
          description: "Complete UX overhaul of an e-commerce platform resulting in 32% increase in conversion rate",
          technologies: ["Figma", "React", "CSS Grid", "User Testing"],
          image_path: "/images/project1.jpg",
          link: "#project1"
        },
        %{
          title: "Mobile Banking App",
          description: "Intuitive financial management application with focus on accessibility and security",
          technologies: ["Sketch", "Swift", "User Research", "Prototyping"],
          image_path: "/images/project2.jpg",
          link: "#project2"
        },
        %{
          title: "Healthcare Portal",
          description: "Patient-centered interface that simplifies medical record access and appointment scheduling",
          technologies: ["Adobe XD", "Angular", "Design System", "Information Architecture"],
          image_path: "/images/project3.jpg",
          link: "#project3"
        }
      ]
    )}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen">
      <div class="status-bar">
        <div id="time-display" phx-hook="UpdateTime">
          <%= @current_time %> San Francisco, CA
        </div>
        <div>
          Your Name
        </div>
      </div>

      <div class="main-content">
        <div class="mb-16">
          <h1 class="heading-large mb-12">Selected Work</h1>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
            <%= for project <- @projects do %>
              <div class="project-card">
                <div class="aspect-video bg-gray-100 mb-4">
                  <!-- Replace with actual images when available -->
                  <div class="w-full h-full flex items-center justify-center text-gray-400">
                    Project Image
                  </div>
                </div>
                <h3 class="text-xl font-semibold mb-2"><%= project.title %></h3>
                <p class="text-gray-600 mb-4"><%= project.description %></p>
                <div class="flex flex-wrap gap-2 mb-4">
                  <%= for tech <- project.technologies do %>
                    <span class="px-3 py-1 bg-gray-100 text-gray-600 text-xs rounded-full"><%= tech %></span>
                  <% end %>
                </div>
                <.link href={project.link} class="text-sm text-gray-600 hover:text-gray-900">View Project Details →</.link>
              </div>
            <% end %>
          </div>
        </div>

        <div class="sidebar-nav">
          <.link href="/">Home</.link>
          <.link href="/work" class="text-gray-900 font-medium">View Work</.link>
          <.link href="/process">My Process</.link>
          <.link href="/contact">Get in Touch</.link>
          <.link href="/about">About Me</.link>
        </div>
      </div>
    </div>
    """
  end
end
