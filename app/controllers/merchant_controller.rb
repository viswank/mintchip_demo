class MerchantController < ApplicationController
  def buy
    
  end

  def result
    
    cardname = params[:payment]
    if cardname.to_s == "Visa"
      inputCardType = 1
    elsif cardname.to_s == "MasterCard"
      inputCardType = 2
    elsif cardname.to_s == "AMEX"
      inputCardType = 3
    else      
      inputCardType = 4      
    end

    cardnumber = params[:CCnum]
    
    
    
#    transaction2 = Transaction.find(:first, :conditions => { :cc_num => cardnumber, :cardType => inputCardType});
    transaction2 = Transaction.find_by_cc_num_and_cardType(cardnumber, inputCardType)

    
#    transaction2 = Transaction.find_by_cc_num(params[:cc_num])
#    transaction2 = Transaction.find_by_cc_num(cardnumber)



# update the remaining value    
#    transaction.update_attributes(amount: "8.88")
    
#    if transaction = find_every(options).first
#    result
#  else
#    raise RecordNotFound, "Couldn't find #{name} with ID=#{id}#{conditions}"
#  end
   # flash[:success1] = str1;
 
#  flash[:success1] = @transaction1.cc_num.to_s;
#  flash[:success1] = @transaction2.cc_num.to_s;
 
  if transaction2
    flash[:success1] = "Transaction successful";
  else
    flash[:error] = "Transaction failed. Please check credit card details and submit again";
    render 'result'
  end
   
     
  end
  
  
end
