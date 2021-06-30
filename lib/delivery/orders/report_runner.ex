defmodule Delivery.Orders.ReportRunner do
  use GenServer

  require Logger

  alias Delivery.Orders.Report

  @time 1000 * 1000

  @time_seconds @time / 1000

  # Client

  def start_link(_initial_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # Server

  @impl true
  def init(state) do
    Logger.info("Report Runner started. Reports run each #{@time_seconds} seconds...")
    schedule_report_generation()

    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    Logger.info("Generating report...")

    Report.create()
    schedule_report_generation()

    {:noreply, state}
  end

  def schedule_report_generation do
    Process.send_after(self(), :generate, @time)
  end
end
