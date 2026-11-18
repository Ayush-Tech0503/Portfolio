import 'package:flutter/material.dart';
import '../../../Util/constaint_textstyle.dart';
import '../../../Util/constant_color.dart';
import '../../../Widgets/custome_text.dart';

class TermOfUseScreen extends StatefulWidget {
  const TermOfUseScreen({super.key});

  @override
  State<TermOfUseScreen> createState() => _TermOfUseScreenState();
}

class _TermOfUseScreenState extends State<TermOfUseScreen>
    with TickerProviderStateMixin {
  String location = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: ConstantColor.loginWithOtpButtonColor,
      child: SafeArea(
        child:Scaffold(
/*--------------------------------------appbar section start-------------------------------------*/
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: ConstantColor.primaryBackgroundMainColor,
            iconTheme: const IconThemeData(color: ConstantColor.loginWithOtpButtonColor),
            title: customeText(textAlign: TextAlign.start,
                text: "Terms of Use", style: ConstantTextStyle.secodHearText),
          ),
/*--------------------------------------appbar section end-------------------------------------*/
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: screenWidth/40),
            // padding: EdgeInsets.symmetric(
            //     vertical: screenHeight / 50, horizontal: screenWidth / 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText(
                    text: "Term Of Use".toUpperCase(),
                    style: ConstantTextStyle.secodHearText,
                  ),
                  SizedBox(
                    height: screenHeight / 60,
                  ),
                  const Center(
                    child: Text(
                      style: TextStyle(fontSize: 12),
                      '''Conditions Relating to Your Use of Citybazaronline.com

1. Your Account

If you use the website, you are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer to prevent unauthorised access to your account. You agree to accept responsibility for all activities that occur under your account or password. You should take all necessary steps to ensure that the password is kept confidential and secure and should inform us immediately if you have any reason to believe that your password has become known to anyone else, or if the password is being, or is likely to be, used in an unauthorised manner. Please ensure that the details you provide us with are correct and complete and inform us immediately of any changes to the information that you provided when registering. You can access and update much of the information you provided us with in the Account Information under My Account section of the website. C B Business solution Pvt. Ltd. reserves the right to refuse access to the website, terminate accounts, remove or edit content at any time without notice to you.

2. Privacy

Please review our Privacy Notice, which also governs your visit to citybazaronline.com, to unerstand our practices. The personal information / data provided to us by you during the course of usage of citybazaronline.com will be treated as strictly confidential and in accordance with the Privacy Notice and applicable laws and regulations. If you object to your information being transferred or used, please do not use the website.

3. E-Platform for Communication

You agree, understand and acknowledge that the website is an online platform that enables you to purchase products listed on the website from correspondent seller. You further agree and acknowledge that citybazaronline.com is only a facilitator and is not and cannot be a party to or control in any manner any transactions on the website. Accordingly, the contract of sale of products on the website shall be a strictly bipartite contract between you and the sellers on citybazaronline.com

4. Access to citybazaronline.com

We will do our utmost to ensure that availability of the website will be uninterrupted and that transmissions will be error-free. However, due to the nature of the Internet, this cannot be guaranteed. Also, your access to the website may also be occasionally suspended or restricted to allow for repairs, maintenance, or the introduction of new facilities or services at any time without prior notice. We will attempt to limit the frequency and duration of any such suspension or restriction.

5. Licence for website access

Subject to your compliance with these Conditions of Use and payment of applicable fees, if any, C B Business Solution Private Limited grants you a limited licence to access and make personal use of this website, but not to download (other than page caching) or modify it, or any portion of it, except with express written consent of C B Business Solution Private Limited and / or its affiliates, as may be applicable. This licence does not include any resale or commercial use of this website or its contents; any collection and use of any product listings, descriptions, or prices; any derivative use of this website or its contents; any downloading or copying of account information for the benefit of another seller; or any use of data mining, robots, or similar data gathering and extraction tools.

This website or any portion of this website (including but not limited to any copyrighted material, trademarks, or other proprietary information) may not be reproduced, duplicated, copied, sold, resold, visited, distributed or otherwise exploited for any commercial purpose without express written consent of C B Business Solution Private Limited and / or its affiliates, as may be applicable.

You may not frame or use framing techniques to enclose any trademark, logo, or other proprietary information (including images, text, page layout, or form) of C B Business Solution Private Limited and its affiliates without express written consent. You may not use any meta tags or any other "hidden text" utilising C B Business Solution Private Limited 's or its affiliates' names or trademarks without the express written consent of C B Business Solution Private Limited and / or its affiliates, as applicable. Any unauthorised use terminates the permission or license granted by C B Business Solution Private Limited and / or its affiliates, as applicable.

You are granted a limited, revocable, and non-exclusive right to create a hyperlink to the Welcome page of CityBazarOnline.com as long as the link does not portray C B Business Solution Private Limited, or otherwise offensive matter. You may not use any Citbazaronline logo or other proprietary graphic or trademark as part of the link without express written consent of C B Business Solution Private Limited and / or its affiliates, as may be applicable.

6. Your Conduct

You must not use the website in any way that causes, or is likely to cause, the website or access to it to be interrupted, damaged or impaired in any way You understand that you, and not citybazaronline.com are responsible for all electronic communications and content sent from your computer to us and you must use the website for lawful purposes only. You must not use the website for any of the following:

·        for fraudulent purposes, or in connection with a criminal offense or other unlawful activity to send, use or reuse any material that does not belong to you; or is illegal, offensive (including but not limited to material that is sexually explicit content or which promotes racism, bigotry, hatred or physical harm), deceptive, misleading, abusive, indecent, harassing, blasphemous, defamatory, libelous, obscene, pornographic, pedophilic or menacing; ethnically objectionable, disparaging or in breach of copyright, trademark, confidentiality, privacy or any other proprietary information or right; or is otherwise injurious to third parties; or relates to or promotes money laundering or gambling; or is harmful to minors in any way; or impersonates another person; or threatens the unity, integrity, security or sovereignty of India or friendly relations with foreign States; or objectionable or otherwise unlawful in any manner whatsoever; or which consists of or contains software viruses, political campaigning, commercial solicitation, chain letters, mass mailings or any "spam to cause annoyance, inconvenience or needless anxiety

 

7. Reviews, comments, communications and other content

Users of this website may post reviews, comments and other content; send communications; and submit suggestions, ideas, comments, questions, or other information, as long as the content is not illegal, obscene, abusive, threatening, defamatory, invasive of privacy, infringing of intellectual property rights, or otherwise injurious to third parties, or objectionable and does not consist of or contain software viruses, political campaigning, commercial solicitation, chain letters, mass mailings, or any form of "spam." In the event a user uses a false e-mail address, impersonates any person or entity, or otherwise misleads as to the origin of any content. Citybazaronline.com reserves the right (but not the obligation) to remove, refuse, delete or edit any content that in the sole judgement of citybazaronline.com violates these Conditions of use and, or terminate your permission to access or use this website.

If you do post content or submit material, and unless we indicate otherwise, you

1.           Grant C B Business Solution Private Limited and its affiliates a non-exclusive, royalty-free, irrevocable, perpetual and fully sublicensable rights to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, and display such content throughout the world in any media; and

2.           C B Business Solution Private Limited and its affiliates and sublicensees the right to use the name that you submit in connection with such content, if they choose.

You agree that the rights you grant above are irrevocable during the entire period of protection of your intellectual property rights associated with such content and material. You agree to waive your right to be identified as the author of such content and your right to object to derogatory treatment of such content. You agree to perform all further acts necessary to perfect any of the above rights granted by you to C B Business Solution Private Limited, including the execution of deeds and documents, at its request.

You represent and warrant that you own or otherwise control all of the rights to the content that you post or that you otherwise provide on or through the website; that, as at the date that the content or material is submitted to citybazaronline.com : (i) the content and material is accurate; (ii) use of the content and material you supply does not breach any applicable citybazaronline.com policies or guidelines and will not cause injury to any person or entity (including that the content or material is not defamatory); (iii) the content is lawful. You agree to indemnify C B Business Solution Private Limited and its affiliates for all claims brought by a third party against it or its affiliates arising out of or in connection with a breach of any of these warranties.

8. Claims against Objectionable Content

Because citybazaronline.com lists millions of products for sale offered by sellers on the website and hosts many thousands of comments, it is not possible for us to be aware of the contents of each product listed for sale, or each comment or review that is displayed. Accordingly, Citybazaronline.com operates on a "notice and takedown" basis. If you believe that any content on the website is illegal, offensive (including but not limited to material that is sexually explicit content or which promotes racism, bigotry, hatred or physical harm), deceptive, misleading, abusive, indecent, harassing, blasphemous, defamatory, libelous, obscene, pornographic, pedophilic or menacing; ethnically objectionable, disparaging; or is otherwise injurious to third parties; or relates to or promotes money laundering or gambling; or is harmful to minors in any way; or impersonates another person; or threatens the unity, integrity, security or sovereignty of India or friendly relations with foreign States; or objectionable or otherwise unlawful in any manner whatsoever; or which consists of or contains software viruses, (" Objectionable Content "), please notify us. Once this procedure has been followed, Citybazaronline.com will make all reasonable endeavours to remove such Objectionable Content complained about within a reasonable time.*

9. Copyright, authors' rights and database rights

All content included on the website, such as text, graphics, logos, button icons, images, audio clips, digital downloads, data compilations, and software, is the property of C B Business Solution Private Limited, its affiliates or its content suppliers and is protected by India and international copyright, authors' rights and database right laws. The compilation of all content on this website is the exclusive property C B Business Solution Private Limited and its affiliates and is protected by laws of India and international copyright and database right laws. All software used on this website is the property of C B Business Solution Private Limited, its affiliates or its software suppliers and is protected by India and international copyright and author' rights laws.

You may not systematically extract/ or re-utilise parts of the contents of the website without written consent of C B Business Solution Private Limited and / or its affiliate's (as may be applicable) express. In particular, you may not utilise any data mining, robots, or similar data gathering and extraction tools to extract (whether once or many times) for re-utilisation of any substantial parts of this website, without C B Business Solution Private Limited and / or its affiliate's (as may be applicable) express written consent. You may also not create and/ or publish your own database that features substantial (eg: prices and product listings) parts of this website without C B Business Solution Private Limited and / or its affiliate's (as may be applicable) express written consent.

10. Intellectual Property Claims

C B Business Solution Private Limited and its affiliates respect the intellectual property of others. If you believe that your intellectual property rights have been used in a way that gives rise to concerns of infringement, please follow our Notice and Procedure for Making Claims of Right Infringements.

11. Disclaimer

You acknowledge and undertake that you are accessing the services on the website and transacting at your own risk and are using your best and prudent judgment before entering into any transactions through the website. We shall neither be liable nor responsible for any actions or inactions of sellers nor any breach of conditions, representations or warranties by the sellers or manufacturers of the products and hereby expressly disclaim and any all responsibility and liability in that regard. We shall not mediate or resolve any dispute or disagreement between you and the sellers or manufacturers of the products.

We further expressly disclaim any warranties or representations (express or implied) in respect of quality, suitability, accuracy, reliability, completeness, timeliness, performance, safety, merchantability, fitness for a particular purpose, or legality of the products listed or displayed or transacted or the content (including product or pricing information and/or specifications) on the website. While we have taken precautions to avoid inaccuracies in content, this website, all content, information (including the price of products), software, products, services and related graphics are provided as is, without warranty of any kind. We do not implicitly or explicitly support or endorse the sale or purchase of any products on the website. At no time shall any right, title or interest in the products sold through or displayed on the website vest with citybazaronline.com nor shall citybazaronline.com have any obligations or liabilities in respect of any transactions on the website.

12. Indemnity and Release

You shall indemnify and hold harmless C B Business Solution Private Limited, its subsidiaries, affiliates and their respective officers, directors, agents and employees, from any claim or demand, or actions including reasonable attorney's fees, made by any third party or penalty imposed due to or arising out of your breach of these Conditions of Use or any document incorporated by reference, or your violation of any law, rules, regulations or the rights of a third party.

You hereby expressly release C B Business Solution Private Limited and/or its affiliates and/or any of its officers and representatives from any cost, damage, liability or other consequence of any of the actions/inactions of the vendors and specifically waiver any claims or demands that you may have in this behalf under any statute, contract or otherwise.

13. Children

Use of citybazaronline.com is available only to persons who can form a legally binding contract under the Indian Contract Act, 1872. If you are a minor i.e. under the age of 18 years, you may use citybazaronline only with the involvement of a parent or guardian.

14. Other Businesses

Parties other C B Business Solution Private Limited and its affiliates may operate stores, provide services, or sell product lines on citybazaronline.com. For example, businesses and individuals offer products via Marketplace. In addition, we provide links to the websites of affiliated companies and certain other businesses. We are not responsible for examining or evaluating, and we do not warrant or endorse the offerings of any of these businesses or individuals, or the content of their websites. C B Business Solution Private Limited does not assume any responsibility or liability for the actions, products, and content of any of these and any other third-parties. You can tell when a third-party is involved in your transactions, and we may share customer information related to those transactions with that third-party. You should carefully review their privacy statements and other conditions of use.

15. Communications

When you visit Citybazaronline.com, you are communicating with us electronically. You will be required to provide a valid phone number for making contact with seller. We may communicate with you by e-mail, SMS, phone call or by posting notices on the website or by any other mode of communication. For contractual purposes, you consent to receive communications (including transactional, promotional and/or commercial messages), from us with respect to your use of the website and/or your order placed on the website.

16. Losses

We will not be responsible for any business loss (including loss of profits, revenue, contracts, anticipated savings, data, goodwill or wasted expenditure) or any other indirect or consequential loss that is not reasonably foreseeable to both you and us when you commenced using the website.

17. Alteration of Service or Amendements to the Conditions

We reserve the right to make changes to our website, policies, and these Conditions of Use at any time. You will be subject to the policies and Conditions of Use in force at the time that you use the website unless any change to those policies or these conditions is required to be made by law or government authority. If any of these conditions is deemed invalid, void, or for any reason unenforceable, that condition will be deemed severable and will not affect the validity and enforceability of any remaining condition.

18. Events beyond our reasonable control

We will not be held responsible for any delay or failure to comply with our obligations under these conditions if the delay or failure arises from any cause which is beyond our reasonable control. This condition does not affect your statutory rights.

19. Waiver

If you breach these conditions and we take no action, we will still be entitled to use our rights and remedies in any other situation where you breach these conditions.

20. Governing law and Jurisdiction

These conditions are governed by and construed in accordance with the laws of India. You agree, as we do, to submit to the exclusive jurisdiction of the courts at Indore M. P.

21. Our Details

This website is operated by C B Business Solution Private Limited.

For the Citybazaronline.com website, you could contact us via email conatact@citybazaronline.com

24. Citybazaronline Software Terms

In addition to these Conditions of Use, the terms found below apply to any software (including any updates or upgrades to the software and any related documentation) that we make available to you from time to time for your use in connection with citybazaronline.com .

Notice and Procedure for Making Claims of Right Infringements

If you believe that your rights are being infringed, you may send the issue to contact@citybazaronline.com. We respond expeditiously to rights owners and their agents who complete and submit the Notice to communicate concerns about any alleged infringement.

Upon receipt of a Notice we may take certain actions, including removing information or an item, all of which are taken without any admission as to liability and without prejudice to any rights, remedies or defenses, all of which are expressly reserved. Furthermore, in submitting a Notice Form, you grant to C B Business Solution Private Limited the right to use, reproduce, modify, adapt, publish, translate, create derivative works from, and display its content throughout the world in any media. This includes forwarding the Notice Form to the parties involved in the provision of the allegedly infringing content. You agree to indemnify C B Business Solution Private Limited for all claims brought by a third party against C B Business Solution Private Limited arising out of or in connection with the submission of a Notice Form.

Note on Third Party Seller Listings: Please keep in mind that Third Party Seller listings are merely hosted on Citybazaronline.com and are posted solely at the direction of Third Party Sellers who may be contacted via their "Seller Information" page, accessible from any of their listings.

Important Warning: giving false, misleading or inaccurate information in the Notice Form to citybazaronlin may result in civil and/or criminal liability. You should contact a legal advisor should you have any questions.

Important Warning: Giving false, misleading or inaccurate information in the Notice to Citybazaronline.com may result in civil and/ or criminal liability.

Notice to Citybazaronline.com of Objectionable Content

In the matter of Citybazaronline.com I, [Please set out your full name] of [please give your postal address], [please set your occupation] , says as follows:

1.           I refer to the website www.Citybazaronline.com ("the website"). I make this statement in support of my giving Citybazaronline.com notice that, via the website, it is causing or contributing to the publication of Objectionable Content.

2.           The Objectionable Content (delete whichever paragraph is not applicable): (a) appear in a product being sold on Citybazaronline.com via the website entitled [please state the product name and its seller]. The Objectionable Content appear on page [please state the link of page where you consider the words constitute Objectionable Content]. OR (b) appear on the website at [please cut and paste the address of the relevant Web page from the website where the Objectionable Content appears].

3.           The words/ content that I consider to be Objectionable Content are [please repeat the exact words you are complaining about].

4.           This content is Objectionable Content because [please state why you consider the content is Objectionable Content].

5.           I understand that this statement may be used in any court proceedings that may arise out of or relating to the Objectionable Content which I have complained about.

Statement of Truth

I declare the facts stated above to be true.

Signed:

Dated:

Please read the conditions of use carefully before using the Citybazaronline.com website. By using the Citybazaronline.com website, you signify your agreement to be bound by these conditions.

 

Citybazaronline Software Terms

1. Use of the Citybazaronline.com Software

You may use Citybazaronline.com Software solely for purposes of enabling you to use and enjoy the Citybazaronline.com Services as provided by Citybazaronline.com, and as permitted by the Conditions of Use, these Citybazaronline Software Terms and any Terms. You may not incorporate any portion of the Citybazaronline.com Software into your own programs or compile any portion of it in combination with your own programs, transfer it for use with another service, or sell, rent, lease, lend, loan, distribute or sub-license the Citybazaronline.com Software or otherwise assign any rights to the Citybazaronline.com Software in whole or in part. You may not use the Citybazaronline.com Software for any illegal purpose. We may cease providing any Citybazaronline.com Software and we may terminate your right to use any Citybazaronline.com Software at any time. Your rights to use the Citybazaronline.com Software will automatically terminate without notice from us if you fail to comply with any of these Citybazaronline.com Software Terms, the Conditions of Use or any other Terms. Additional third party terms contained within or distributed with certain Citybazaronline.com Software that are specifically identified in related documentation may apply to that Citybazaronline.com Software (or software incorporated with the Citybazaronline.com Software) and will govern the use of such software in the event of a conflict with these Conditions of Use. All software used in any Citybazaronline.com Service is the property of CB Business solution Pvt. Ltd. and/or its affiliates or its software suppliers and protected by laws of India including but not limited to any other applicable copyright laws.

 

 

2. Use of Third Party Services

When you use the Citybazaronline.com Software, you may also be using the services of one or more third parties, such as a wireless carrier or a mobile platform provider. Your use of these third party services may be subject to the separate policies, terms of use, and fees of these third parties.

3. No Reverse Engineering

You may not, and you will not encourage, assist or authorize any other person to copy, modify, reverse engineer, decompile or disassemble, or otherwise tamper with, the Citybazaronline.com Software, whether in whole or in part, or create any derivative works from or of the Citybazaronline.com Software.

Updates

In order to keep the Citybazaronline.com Software up-to-date, we may offer automatic or manual updates at any time and without notice to you.

Listing or Selling Products

As a registered seller, you shall list item(s) for sale on the Platform in accordance with the policies which are incorporated by way of reference in this terms of use. You must be legally able to sell the item(s) you list for sale on our Platform and must have all the necessary licences and permits required for such sale. You must ensure that the listed items do not infringe upon the intellectual property, trade secret or other proprietary rights or rights of publicity or privacy rights of third parties. Listings may only include text descriptions, graphics,  pictures or videos that describe your item for sale. All items must be listed in an appropriate category on the Platform. All listed items must be kept in stock for successful fulfilment of sales. The listing description of the item must not be misleading and must describe actual condition of the product.

Compliance on selling of goods/services

You(seller) shall also ensure full compliance with the provisions of Integrated Goods and Services Tax (IGST), Central Goods and Services Tax (CGST) and Union Territory Goods and Services Tax (UTGST) or State Goods and Services Tax (SGST) in respect of the goods/services supplied by you. 

It is your responsibility to charge appropriate goods and services taxes on the supplies effected and remittance of the same to the Government.  C B Business solution Pvt. Ltd. shall not be responsible for any deficiency and/ or omission on your part.

In the event of any conflict between the terms of this clause and any other clause in these terms of use, the provisions of this clause will prevail.

 

Conditions of Sale (between Sellers and the Customer)

Please read these conditions carefully before placing an order for any products with the Sellers ("We" or "Our" or "Us", wherever applicable) on the Citybazaronline.com (the website). These conditions signify your agreement to be bound by these conditions.

In addition, when you use any current or future Citybazaronline.com service (eg: Wishlist or Marketplace or want to buy), you will also be subject to the terms, guidelines and conditions applicable to that service ("Terms"). If these Conditions of Sale are inconsistent with such Terms, the Terms will control.

1. Conditions Relating to the Sale of Products to You

This section deals with conditions relating to the sale of products on the website by corresponding seller to you.

2. Pricing and availability

We list availability information for products sold by seller on the website, including on each product information page. Beyond what we say on that page or otherwise on the website, we cannot be more specific about availability

3. Taxes

You shall be responsible for payment of all fees/costs/charges associated with the purchase of products from seller and you agree to bear any and all applicable taxes including but not limited to VAT/CST, service tax, GST, duties and cesses etc.

4. Health & Safety

By purchasing any product from our Home & Kitchen shop, you acknowledge that you have read and understood our Health & Safety Guidelines.

5. Children

Use of citybazaronline.com is available only to persons who can form a legally binding contract under the Indian Contract Act, 1872. If you are a minor i.e. under the age of 18 years, you may use website only with the involvement of a parent or guardian.

6. Communications

When you visit Citybazaronline.com, you are communicating with us electronically. You will be required to provide a valid phone number while placing an order with seller. We may communicate with you by e-mail, SMS, phone call or by posting notices on the website or by any other mode of communication. For contractual purposes, you consent to receive communications including SMS, e-mails or phone calls from us or seller with respect to your order or your interest in any product.

7. Losses

We will not be responsible for any business loss (including loss of profits, revenue, contracts, anticipated savings, data, goodwill or wasted expenditure) or any other indirect or consequential loss that is not reasonably foreseeable to both you and us when a contract for the sale of goods by us to you was formed.

8. Alteration or Amendments to the Conditions

We reserve the right to make changes to our policies, and these Conditions of Sale at any time. If any of these conditions is deemed invalid, void, or for any reason unenforceable, that condition will be deemed severable and will not affect the validity and enforceability of any remaining condition.

9. Events beyond our reasonable control

We will not be held responsible for any delay or failure to comply with our obligations under these conditions if the delay or failure arises from any cause which is beyond our reasonable control. This condition does not affect your statutory rights.

 

Product Description

C B Business solution Pvt. Ltd. does not warrant that product description or other content on the Platform is accurate, complete, reliable, current, or error-free and assumes no liability in this regard.

Breach

Without limiting other remedies, we may limit your activity, immediately remove your information, warn other users of your actions immediately, temporarily/indefinitely suspend/terminate/block your account and/or refuse you access to the Platform in the event of, including but not limited to, the following:

1. if you breach the Terms of use, privacy policy or other policies (if any);

2. if we are unable to verify or authenticate any information you provide; or

3. if it is believed that your actions may cause legal liability for you, other users, or us;

We may at any time, at our sole discretion, reinstate suspended sellers. A seller that has been suspended or blocked may not register or attempt to register with us or use the Platform (through itself or any other entity or legal form) in any manner whatsoever until such time that such a seller is reinstated by us.

 

10. Waiver

If you breach these conditions and we take no action, we will still be entitled to use our rights and remedies in any other situation where you breach these conditions.

11. Governing Law and Jurisdiction

These conditions are governed by and construed in accordance with the laws of India, and. You agree, as we do, to submit to the exclusive jurisdiction of the courts at Indore.''',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
