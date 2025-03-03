# lib/portfolio_web/live/contact_live.ex
defmodule PortfolioWeb.ContactLive do
  use PortfolioWeb.BaseLive
  alias Phoenix.LiveView.JS

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> mount_common("contact")
      |> assign(:page_title, "Contact")
      |> assign(:form, to_form(%{"name" => "", "email" => "", "message" => "", "project_type" => ""}))
      |> assign(:form_submitted, false)
      |> assign(:form_error, false)
    }
  end

  def render(assigns) do
    ~H"""
    <div id="page-container" phx-hook="PageTransition" class="min-h-screen bg-white">
      <main>
        <div class="w-full mx-auto px-8 md:px-12 pt-16 flex flex-col md:flex-row">
          <div class="flex-1 md:pr-8 lg:pr-12 pt-12 md:max-w-[75%] lg:max-w-[80%]">
            <div>
              <h1 id="contact-heading" class="text-4xl md:text-5xl font-bold leading-tight mb-8" phx-hook="FadeIn">
                Let's Connect
              </h1>

              <div class="grid grid-cols-1 md:grid-cols-2 gap-12 mb-16">
                <div id="contact-info" phx-hook="FadeIn">
                  <p class="text-xl text-gray-600 mb-6">
                    Have a project in mind or just want to say hello? I'd love to hear from you.
                  </p>
                  <p class="text-gray-600 mb-10">
                    Fill out the form or reach out directly through one of the channels below. I'm always open to discussing new projects, creative ideas, or opportunities to be part of your vision.
                  </p>

                  <div class="space-y-6">
                    <div class="flex items-start">
                      <div class="w-8 h-8 flex items-center justify-center mr-4 mt-1">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[rgb(211,84,0)]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                        </svg>
                      </div>
                      <div>
                        <h3 class="text-lg font-medium mb-1">Email</h3>
                        <a href="mailto:your.email@example.com" class="text-gray-600 hover:text-[rgb(211,84,0)] transition-colors">your.email@example.com</a>
                      </div>
                    </div>

                    <div class="flex items-start">
                      <div class="w-8 h-8 flex items-center justify-center mr-4 mt-1">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[rgb(211,84,0)]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                      </div>
                      <div>
                        <h3 class="text-lg font-medium mb-1">Location</h3>
                        <p class="text-gray-600">Chicago, IL</p>
                      </div>
                    </div>

                    <div class="flex items-start">
                      <div class="w-8 h-8 flex items-center justify-center mr-4 mt-1">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-[rgb(211,84,0)]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
                        </svg>
                      </div>
                      <div>
                        <h3 class="text-lg font-medium mb-1">Social</h3>
                        <div class="flex space-x-4">
                          <a href="https://linkedin.com/" target="_blank" class="text-gray-600 hover:text-[rgb(211,84,0)] transition-colors">LinkedIn</a>
                          <a href="https://twitter.com/" target="_blank" class="text-gray-600 hover:text-[rgb(211,84,0)] transition-colors">Twitter</a>
                          <a href="https://dribbble.com/" target="_blank" class="text-gray-600 hover:text-[rgb(211,84,0)] transition-colors">Dribbble</a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div id="contact-form" phx-hook="FadeIn">
                  <%= if @form_submitted do %>
                    <div class="p-6 bg-green-50 rounded-sm mb-4">
                      <h3 class="text-lg font-medium text-green-800 mb-2">Message sent successfully!</h3>
                      <p class="text-green-700">
                        Thank you for reaching out. I'll get back to you as soon as possible.
                      </p>
                    </div>
                    <button
                      phx-click="reset_form"
                      class="text-[rgb(211,84,0)] hover:text-[rgb(180,70,0)] transition-colors inline-flex items-center">
                      Send another message
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                      </svg>
                    </button>
                  <% else %>
                    <%= if @form_error do %>
                      <div class="p-6 bg-red-50 rounded-sm mb-4">
                        <h3 class="text-lg font-medium text-red-800 mb-2">Oops! Something went wrong.</h3>
                        <p class="text-red-700">
                          There was an error sending your message. Please try again or contact me directly via email.
                        </p>
                      </div>
                    <% end %>

                    <.form for={@form} phx-submit="submit_form" class="space-y-6" phx-hook="FormValidation">
                      <div>
                        <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                        <input
                          type="text"
                          id="name"
                          name="name"
                          placeholder="Brian H."
                          required
                          class="w-full px-4 py-2 border border-gray-300 rounded-sm focus:ring-[rgb(211,84,0)] focus:border-[rgb(211,84,0)] outline-none transition-colors" />
                      </div>

                      <div>
                        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                        <input
                          type="email"
                          id="email"
                          name="email"
                          placeholder="Your email address"
                          required
                          class="w-full px-4 py-2 border border-gray-300 rounded-sm focus:ring-[rgb(211,84,0)] focus:border-[rgb(211,84,0)] outline-none transition-colors" />
                      </div>

                      <div>
                        <label for="project_type" class="block text-sm font-medium text-gray-700 mb-1">Project Type</label>
                        <select
                          id="project_type"
                          name="project_type"
                          class="w-full px-4 py-2 border border-gray-300 rounded-sm focus:ring-[rgb(211,84,0)] focus:border-[rgb(211,84,0)] outline-none transition-colors">
                          <option value="">Select a project type</option>
                          <option value="ux_design">UX Design</option>
                          <option value="ui_design">UI Design</option>
                          <option value="web_development">Web Development</option>
                          <option value="design_system">Design System</option>
                          <option value="other">Other</option>
                        </select>
                      </div>

                      <div>
                        <label for="message" class="block text-sm font-medium text-gray-700 mb-1">Message</label>
                        <textarea
                          id="message"
                          name="message"
                          rows="5"
                          placeholder="Tell me about your project or inquiry"
                          required
                          class="w-full px-4 py-2 border border-gray-300 rounded-sm focus:ring-[rgb(211,84,0)] focus:border-[rgb(211,84,0)] outline-none transition-colors"></textarea>
                      </div>

                      <div>
                        <button
                          type="submit"
                          class="px-6 py-3 bg-[rgb(211,84,0)] text-white hover:bg-[rgb(180,70,0)] transition-colors rounded-sm flex items-center">
                          Send Message
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                          </svg>
                        </button>
                      </div>
                    </.form>
                  <% end %>
                </div>
              </div>

              <div id="availability" class="mt-16 pt-12 border-t border-gray-200" phx-hook="FadeIn">
                <h2 class="text-2xl font-light mb-6">Current Availability</h2>
                <p class="text-gray-600 mb-4">
                  I'm currently taking on new projects starting <span class="font-medium">September 2024</span>.
                </p>
                <p class="text-gray-600">
                  I typically work with clients on a project basis, but I'm also open to discussing part-time collaboration for the right opportunity. Feel free to reach out, and we can discuss your specific needs.
                </p>
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

  def handle_event("submit_form", params, socket) do
    # In a real app, you would process form data here, perhaps sending an email
    # or storing the inquiry in a database

    # For demonstration purposes, we'll simulate a successful submission
    # In a real app, you would add proper validation and error handling

    # Simulate a delay for form processing
    Process.sleep(1000)

    # For demo purposes - random success/error to demonstrate both states
    # In a real app, this would be based on actual success/failure of form processing
    form_success = :rand.uniform(10) > 2

    if form_success do
      {:noreply, assign(socket, form_submitted: true, form_error: false)}
    else
      {:noreply, assign(socket, form_submitted: false, form_error: true)}
    end
  end

  def handle_event("reset_form", _, socket) do
    {:noreply, assign(socket,
      form: to_form(%{"name" => "", "email" => "", "message" => "", "project_type" => ""}),
      form_submitted: false,
      form_error: false
    )}
  end
end
