# Fiyuu Challenge
1. Projenin ObjC ile yazilmasi (Swift ile de yazabilirsin)

2. Yaratilan projenin min iOS 9 desteklemesi

3. Yaratilan projenin cocoapods ile entegre olmasi

4. Network call’lari icin AFNetworking’in kullanilmasi

5. Sana mail’de paylastigim token’in network call’larinda header’a eklenmesi. Key:token Value: abcd…. ornek : 

“[sessionManager.requestSerializer setValue:@“XpcLEEIMqSuRiDlCkww0sww82NTx5fyRE3y5UOxA3mnSlA4/ySgTpAAEa67fKuBcoiLmjO3K8upOmZxNp2IXIxZSCf6twi67bOsUb5DLAsvi1OXPhLkwbL7pzYwb9vZc/Vlhcr+czKIz7HUpQpH8JKiQUw==" forHTTPHeaderField:@"token"];”

6. scanBrands endpoint’inden gelen markalarin adlari ve marka imajlarinin bir tabloda gosterilmesi

7. getBrandDetails2 endpoint’inden donen sonuclarin urun ismi, varsa aciklamasi ve varsa urun gorselinin (tek gorsel) UITableView ‘da gosterilmesi.

8. addressScan endpoint’inden gelen sonuclardaki adreslerin bir tabloda listelenmesi ve secilen adresin haritada(Native mapkit veya GoogleMaps) bir pin ve zoom edilmis bir sekilde gosterilmesi.

Kullanabilecegin token : XpcLEEIMqSuRiDlCkww0sww82NTx5fyRE3y5UOxA3mnSlA4/ySgTpAAEa67fKuBcoiLmjO3K8upOmZxNp2IXIxZSCf6twi67bOsUb5DLAsvi1OXPhLkwbL7pzYwb9vZc/Vlhcr+czKIz7HUpQpH8JKiQUw==

Baglanti icin kullanilacak URL’ler

1. https://api-dev.fiyuu.com.tr/customer/product/scanBrands-1.0 [Butun markalarin listelenmesini saglar, bu endpoint’e bos bir payload gonderebilirsin, fiyuu  icerisindeki butun markalari listeler. Header’da token oldugu surece]
2. https://api-dev.fiyuu.com.tr/customer/product/getBrandDetails2 [Bu endpoint’e bi onceki endpoint’den gelen brandId degiskenini gondermen gerekiyor, bu degisken sayesinde secmis oldugun markanin butun urunlerini alabilirsin]

ornek payload: 
{
"brandId" : "4bfc8bb5-9469-421b-bc41-bb6ff9c1a562"
}

3. https://api-dev.fiyuu.com.tr/customer/address/scan-2.0 [Bu endpoint’e bos bir request gonderebilirsin. token’in bagli oldugu kullanici yaratilmis adresleri donecektir.

Butun request’ler ve responselarin hepsi JSON olucak. Text ve HTML’i backend kabul etmeyecektir.
