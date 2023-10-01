//
//  Quotes.swift
//  CultureCal
//
//  Created by Kelly Brown on 6/12/23.
//

import Foundation
import SwiftUI

struct Quote: Identifiable,Equatable {
    let id = UUID()
    let text: String
    let author: String
    let imageName: String
    let additionalInfo: String
}
let quotes: [Quote] = [
    Quote(text: "Success is to be measured not so much by the position that one has reached in life as by the obstacles which he has overcome while trying to succeed.", author: "Booker T. Washington", imageName: "booker_t_washington", additionalInfo: "Booker T. Washington was an African American educator, author, and leader of the late 19th and early 20th centuries."),
    Quote(text: "I refuse to accept the view that mankind is so tragically bound to the starless midnight of racism and war that the bright daybreak of peace and brotherhood can never become a reality.", author: "Martin Luther King Jr.", imageName: "martin_luther_king_jr", additionalInfo: "Martin Luther King Jr. was a prominent leader of the civil rights movement in the United States."),
    Quote(text: "If there is no struggle, there is no progress.", author: "Frederick Douglass", imageName: "frederick_douglass", additionalInfo: "Frederick Douglass was an African American social reformer, abolitionist, writer, and statesman."),
    Quote(text: "Hold fast to dreams, for if dreams die, life is a broken-winged bird that cannot fly.", author: "Langston Hughes", imageName: "langston_hughes", additionalInfo: "Langston Hughes was an American poet, social activist, novelist, playwright, and columnist."),
    Quote(text: "The cost of liberty is less than the price of repression.", author: "W.E.B. Du Bois", imageName: "web_du_bois", additionalInfo: "W.E.B. Du Bois was an American sociologist, historian, civil rights activist, and author."),
    Quote(text: "Change will not come if we wait for some other person or some other time. We are the ones we've been waiting for. We are the change that we seek.", author: "Barack Obama", imageName: "barack_obama", additionalInfo: "Barack Obama was the 44th President of the United States."),
    Quote(text: "Every great dream begins with a dreamer. Always remember, you have within you the strength, the patience, and the passion to reach for the stars to change the world.", author: "Harriet Tubman", imageName: "harriet_tubman", additionalInfo: "Harriet Tubman was an American abolitionist and political activist."),
    Quote(text: "The most common way people give up their power is by thinking they don't have any.", author: "Alice Walker", imageName: "alice_walker", additionalInfo: "Alice Walker is an American novelist, short story writer, poet, and social activist."),
    Quote(text: "In recognizing the humanity of our fellow beings, we pay ourselves the highest tribute.", author: "Thurgood Marshall", imageName: "thurgood_marshall", additionalInfo: "Thurgood Marshall was an American lawyer and civil rights activist who served as the first African American Associate Justice of the Supreme Court of the United States."),
    Quote(text: "The battles that count aren't the ones for gold medals. The struggles within yourself—the invisible, inevitable battles inside all of us—that's where it's at.", author: "Jesse Owens", imageName: "jesse_owens", additionalInfo: "Jesse Owens was an American track and field athlete who specialized in sprinting and long jump."),
  
   
]
