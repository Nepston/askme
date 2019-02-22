module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def sklonenie(number, vopros, voprosa, voprosov)
    ostatok = number % 100

    return voprosov if ostatok.between?(11, 14)

    ostatok = number % 10

    case ostatok
    when 1 then return vopros
    when 2..4 then return voprosa
    when 5..9, 0 then return voprosov
    end
  end


  def sklonenie(number, vopros, voprosa, voprosov)
    tens = number % 100 / 10 #вычисляем десятки в классе единиц
    ones = number % 10 #вычисляем единицы в классе единиц

    if tens == 1
      return voprosov  # Для 11- 12 — родительный падеж и множественное число
    elsif ones == 1  # Для 1 — именительный падеж (Кто?/Что? — вопрос)
      return vopros
    elsif ones >= 2 && ones <= 4 # Для 2-4 — родительный падеж (2 Кого?/Чего? — вопроса)
      return voprosa
    else
      return voprosov  # 5-9, 0 — родительный падеж и множественное число (8 Кого?/Чего? — вопросов)
    end
  end
end
