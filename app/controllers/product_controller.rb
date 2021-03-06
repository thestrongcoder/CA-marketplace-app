class ProductController < ApplicationController
    before_action :authenticate_user!
    # view all products
    def index
        @product = Product.all
    end

    # show individual product
    def show
        @product = Product.find(params[:id])
    end

    # new product
    def new
        @product = Product.new
    end

    # create product
    def create
        @product = Product.new(product_params)
        @product.user_id = current_user.id
        @product.brand_id = params[:product][:brand]
        @product.category_id = params[:product][:category]
        @product.picture.attach(params[:product][:picture])
        
        respond_to do |format|
          if @product.save
            format.html { redirect_to @product, notice: 'Product was successfully created.' }
            format.json { render :show, status: :created, location: @product }
          else
            format.html { render :new }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      end

      # edit product
      def edit
        @product = Product.find(params[:id])
      end

      # update product
      def update
        @product = Product.find(params[:id])
        @product.user_id = current_user.id
        @product.brand_id = params[:product][:brand]
        @product.category_id = params[:product][:category]
         if params[:product][:picture] 
          @product.picture.attach(params[:product][:picture])
         end
        respond_to do |format|
          if @product.update(product_params)
            format.html { redirect_to @product, notice: 'The product was successfully updated.' }
            format.json { render :show, status: :ok, location: @product }
          else
            format.html { render :edit }
            format.json { render json: @product.errors, status: :unprocessable_entity }
          end
        end
      end

      
      # destroy product 
      def destroy
        Product.destroy(params[:id])
        respond_to do |format|
          format.html { redirect_to products_path, notice: 'This product was successfully removed' }
          format.json { head :no_content }
        end
      end


    private
    def product_params 
        params.require(:product).permit(:name, :condition, :description, :price)
    end


end
