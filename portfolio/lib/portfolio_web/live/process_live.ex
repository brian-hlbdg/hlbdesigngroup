# lib/portfolio_web/live/process_live.ex
defmodule PortfolioWeb.ProcessLive do
  use PortfolioWeb.BaseLive

  def mount(_params, _session, socket) do
    process_steps = [
      %{
        id: "discover",
        title: "Discover",
        description: "Understanding the problem space through research, interviews, and discovery workshops. I believe in starting every project by developing a deep understanding of user needs and business goals.",
        details: [
          "User interviews and contextual inquiry",
          "Stakeholder workshops",
          "Competitive analysis",
          "Market research",
          "User journey mapping"
        ],
        tools: ["Miro", "Lookback", "Figma", "UserZoom"],
        image: "/images/process/discover.jpg"
      },
      %{
        id: "define",
        title: "Define",
        description: "Synthesizing research findings to define the core problems and opportunities. This phase is about framing the challenge and establishing clear metrics for success.",
        details: [
          "Problem framing",
          "User personas and scenarios",
          "Information architecture",
          "Project requirements",
          "Success metrics definition"
        ],
        tools: ["Figma", "Miro", "Notion", "Optimal Workshop"],
        image: "/images/process/define.jpg"
      },
      %{
        id: "design",
        title: "Design",
        description: "Exploring solutions through ideation, prototyping, and iterative design. I focus on collaborative design practices that bring together different perspectives.",
        details: [
          "Sketching and ideation",
          "Wireframing",
          "UI design",
          "Prototyping",
          "Design systems development"
        ],
        tools: ["Figma", "Principle", "Framer", "InVision"],
        image: "/images/process/design.jpg"
      },
      %{
        id: "test",
        title: "Test",
        description: "Validating designs through usability testing and feedback cycles. I believe in testing early and often to uncover insights and refine solutions.",
        details: [
          "Usability testing",
          "A/B testing",
          "Heuristic evaluation",
          "Accessibility testing",
          "Design reviews"
        ],
        tools: ["UserTesting", "Optimal Workshop", "Hotjar", "WAVE"],
        image: "/images/process/test.jpg"
      },
      %{
        id: "deliver",
        title: "Deliver",
        description: "Refining designs and supporting implementation. I work closely with development teams to ensure the final product matches the design intent and meets user needs.",
        details: [
          "Design specifications",
          "Developer handoff",
          "Implementation support",
          "Quality assurance",
          "Launch preparation"
        ],
        tools: ["Zeplin", "Figma", "GitHub", "Jira"],
        image: "/images/process/deliver.jpg"
      },
      %{
        id: "evolve",
        title: "Evolve",
        description: "Measuring outcomes and iterating based on data and feedback. Design is never truly finished—I believe in continuous improvement based on real-world usage.",
        details: [
          "Analytics review",
          "Post-launch user research",
          "Performance monitoring",
          "Iterative improvements",
          "Knowledge sharing"
        ],
        tools: ["Google Analytics", "Mixpanel", "Fullstory", "Amplitude"],
        image: "/images/process/evolve.jpg"
      }
    ]

    {:ok,
      socket
      |> mount_common("process")
      |> assign(:page_title, "My Process")
      |> assign(:process_steps, process_steps)
      |> assign(:active_step, "discover")
    }
  end

  def render(assigns) do
    ~H"""
    <div id="page-container" phx-hook="PageTransition" class="min-h-screen bg-white dark:bg-gray-900 transition-colors duration-300">
      <main>
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%]">
            <div>
              <h1 id="process-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-8 text-gray-900 dark:text-white transition-colors" phx-hook="FadeIn">
                My Design Process
              </h1>

              <p id="process-intro" class="text-xl text-gray-600 dark:text-gray-300 max-w-prose mb-12 transition-colors" phx-hook="FadeIn">
                I follow a human-centered design approach that's both structured enough to be reliable and flexible enough to adapt to each project's unique needs. Every step is grounded in understanding user needs and business goals.
              </p>

              <div class="hidden md:flex justify-between mb-16 border-b border-gray-200 dark:border-gray-700 pb-4 transition-colors">
                <%= for step <- @process_steps do %>
                  <button
                    phx-click="set_active_step"
                    phx-value-step={step.id}
                    class={"text-sm font-medium transition-colors " <> if @active_step == step.id, do: "text-primary dark:text-primary", else: "text-gray-600 dark:text-gray-400 hover:text-primary dark:hover:text-primary"}>
                    <%= step.title %>
                  </button>
                <% end %>
              </div>

              <div id="process-steps" class="space-y-20 md:space-y-0">
                <%= for {step, index} <- Enum.with_index(@process_steps) do %>
                  <div
                    id={"step-#{step.id}"}
                    class={"process-step md:hidden " <> if @active_step == step.id, do: "block", else: "hidden"}
                    phx-hook="ScrollReveal">
                    <div class="flex items-start mb-6">
                      <div class="flex-grow">
                        <h2 class="text-2xl font-medium mb-2 text-gray-900 dark:text-white transition-colors"><%= step.title %></h2>
                        <p class="text-gray-600 dark:text-gray-300 mb-4 transition-colors"><%= step.description %></p>
                      </div>
                      <div class="text-4xl font-light text-gray-200 dark:text-gray-700 ml-4 transition-colors"><%= index + 1 %></div>
                    </div>

                    <div class="mb-8">
                      <img src={step.image} alt={step.title <> " phase"} class="w-full h-auto rounded-sm" />
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                      <div>
                        <h3 class="text-lg font-medium mb-4 text-gray-800 dark:text-gray-200 transition-colors">Key Activities</h3>
                        <ul class="space-y-2">
                          <%= for detail <- step.details do %>
                            <li class="flex items-start">
                              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary dark:text-primary mr-2 mt-0.5 flex-shrink-0 transition-colors" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                              </svg>
                              <span class="text-gray-700 dark:text-gray-300 transition-colors"><%= detail %></span>
                            </li>
                          <% end %>
                        </ul>
                      </div>

                      <div>
                        <h3 class="text-lg font-medium mb-4 text-gray-800 dark:text-gray-200 transition-colors">Tools & Methods</h3>
                        <div class="flex flex-wrap gap-2">
                          <%= for tool <- step.tools do %>
                            <span class="text-sm px-3 py-1 bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300 rounded-full transition-colors"><%= tool %></span>
                          <% end %>
                        </div>
                      </div>
                    </div>

                    <div class="flex justify-between mt-12 pt-6 border-t border-gray-200 dark:border-gray-700 md:hidden transition-colors">
                      <%= if index > 0 do %>
                        <button
                          phx-click="set_active_step"
                          phx-value-step={Enum.at(@process_steps, index - 1).id}
                          class="text-sm text-gray-600 dark:text-gray-400 hover:text-primary dark:hover:text-primary transition-colors group inline-flex items-center">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1 group-hover:-translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                          </svg>
                          Previous: <%= Enum.at(@process_steps, index - 1).title %>
                        </button>
                      <% else %>
                        <div></div>
                      <% end %>

                      <%= if index < length(@process_steps) - 1 do %>
                        <button
                          phx-click="set_active_step"
                          phx-value-step={Enum.at(@process_steps, index + 1).id}
                          class="text-sm text-gray-600 dark:text-gray-400 hover:text-primary dark:hover:text-primary transition-colors group inline-flex items-center">
                          <%= Enum.at(@process_steps, index + 1).title %>
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                          </svg>
                        </button>
                      <% else %>
                        <div></div>
                      <% end %>
                    </div>
                  </div>
                <% end %>

                <!-- Desktop view: show all steps in a vertical timeline -->
                <div class="hidden md:block">
                  <%= for {step, index} <- Enum.with_index(@process_steps) do %>
                    <div id={"step-desktop-#{step.id}"} class="process-step-desktop mb-24" phx-hook="ScrollReveal">
                      <div class="flex items-start gap-16">
                        <div class="w-1/2">
                          <div class="flex items-start mb-6">
                            <div class="flex-grow">
                              <h2 class="text-2xl font-medium mb-2 text-gray-900 dark:text-white transition-colors"><%= step.title %></h2>
                              <p class="text-gray-600 dark:text-gray-300 mb-4 transition-colors"><%= step.description %></p>
                            </div>
                            <div class="text-5xl font-light text-gray-200 dark:text-gray-700 ml-4 transition-colors"><%= index + 1 %></div>
                          </div>

                          <div class="grid grid-cols-1 gap-8">
                            <div>
                              <h3 class="text-lg font-medium mb-4 text-gray-800 dark:text-gray-200 transition-colors">Key Activities</h3>
                              <ul class="space-y-2">
                                <%= for detail <- step.details do %>
                                  <li class="flex items-start">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-primary dark:text-primary mr-2 mt-0.5 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                                    </svg>
                                    <span class="text-gray-700 dark:text-gray-300 transition-colors"><%= detail %></span>
                                  </li>
                                <% end %>
                              </ul>
                            </div>

                            <div>
                              <h3 class="text-lg font-medium mb-4 text-gray-800 dark:text-gray-200 transition-colors">Tools & Methods</h3>
                              <div class="flex flex-wrap gap-2">
                                <%= for tool <- step.tools do %>
                                  <span class="text-sm px-3 py-1 bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300 rounded-full transition-colors"><%= tool %></span>
                                <% end %>
                              </div>
                            </div>
                          </div>
                        </div>

                        <div class="w-1/2">
                          <img src={step.image} alt={step.title <> " phase"} class="w-full h-auto rounded-sm shadow-sm" />
                        </div>
                      </div>

                      <%= unless index == length(@process_steps) - 1 do %>
                        <div class="h-16 flex justify-center mt-12">
                          <div class="w-px h-full bg-gray-200 dark:bg-gray-700 transition-colors"></div>
                        </div>
                      <% end %>
                    </div>
                  <% end %>
                </div>
              </div>

              <div id="process-cta" class="mt-16 pt-12 border-t border-gray-200 dark:border-gray-700 transition-colors" phx-hook="FadeIn">
                <h2 class="text-2xl font-light mb-6 text-gray-800 dark:text-gray-200 transition-colors">Let's Work Together</h2>
                <p class="text-gray-600 dark:text-gray-300 mb-8 transition-colors">
                  I apply this process to every project, tailoring the approach to meet specific needs and constraints. Interested in collaborating? Let's discuss how my process can help bring your ideas to life.
                </p>
                <.link navigate={~p"/contact"} class="inline-flex items-center text-primary dark:text-primary hover:text-primary-dark dark:hover:text-primary-dark transition-colors group">
                  Get in touch
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1 group-hover:translate-x-1 transition-transform" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                  </svg>
                </.link>
              </div>
            </div>
          </div>

          <.main_nav active={@active} />
        </div>
      </main>

      <.mobile_menu active={@active} show_menu={@show_menu} />
    </div>
    """
  end

  def handle_event("set_active_step", %{"step" => step_id}, socket) do
    {:noreply, assign(socket, active_step: step_id)}
  end
end
