class ListsController < ApplicationController
  # GET /lists
  # GET /lists.json
  def index
    @lists = current_user.lists
    @todolist = []
    @donelist = []
    @lists.each do |list|
      tmp = []
      list.tasks.each do |task|
        if task.done == true
          tmp.push task
        end
      end
      if tmp.length == list.tasks.length && list.tasks.length != 0
        @donelist.push list
      else
        @todolist.push list
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = List.find(params[:id])
    @tasks = @list.tasks
    @done_list = []
    @undone_list = []
    @tasks.each do |task|
      if task[:done] == true
        @done_list.push task
      else
        @undone_list.push task
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.json
  def new
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
    @tasks = @list.tasks
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(params[:list])
    @list.user_id = current_user.id
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  def update
    @list = List.find(params[:id])
    respond_to do |format|
      if @list.update_attributes(params[:list])
        task_ids = params[:task_ids]
        task_names = params[:task_names]
        notin_ids = []
        if task_ids == nil
          @list.tasks.destroy_all
        else
          task_ids.each_with_index do |id, index|
            task = Task.find(id)
            task.name = task_names[index]
            task.save
            notin_ids.push task.id
          end
          Task.where('id not in (?)', notin_ids).destroy_all
        end
        
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :no_content }
    end
  end

end
