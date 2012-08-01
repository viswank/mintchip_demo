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
  
  result = 1
  
  if transaction2
# reducing amount by 5.00    
    amt = transaction2.amount - 5
    transaction2.amount = amt
    transaction2.save
    if amt < 0
      result = 0
    end

# reducing number of times used by 1
    val = transaction2.onetimeuse - 1
    transaction2.onetimeuse = val
    transaction2.save
    if val < 0
      result = 0
    end
    
  else
    result = 0
  end

    
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
 
#  if transaction2
  if result == 1
    flash[:success1] = "Transaction successful";
  else
    flash[:error] = "Transaction failed. Please check credit card details and submit again";
    render 'result'
  end
   
     
  end
  
  
end
