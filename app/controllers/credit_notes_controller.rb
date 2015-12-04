class CreditNotesController < ApplicationController
  before_action :set_credit_note, only: [:show, :edit, :update, :destroy]
  before_action :invoices
  before_action :role_required

  respond_to :html

  def index
    @credit_notes = CreditNote.all
    respond_with(@credit_notes)
  end

  def show
    respond_with(@credit_note)
  end

  def new
    @credit_note = CreditNote.new
    respond_with(@credit_note)
  end

  def edit
  end

  def create
    @credit_note = CreditNote.new(credit_note_params)
    @credit_note.save
    respond_with(@credit_note)
  end

  def update
    @credit_note.update(credit_note_params)
    respond_with(@credit_note)
  end

  def destroy
    @credit_note.destroy
    respond_with(@credit_note)
  end

  private
    def set_credit_note
      @credit_note = CreditNote.find(params[:id])
    end

    def credit_note_params
      params[:credit_note][:invoice_amount] = params[:invoice][:amount]
      params.require(:credit_note).permit(:reference, :date, :invoice_id, :amount, :received_by)
    end

    def invoices
      @invoices = Invoice.all.where.not(amount: 0.0)
      @invoices << @credit_note.try(:invoice) if @credit_note and @invoices
    end
end
