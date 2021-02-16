import 'package:MagicFlutter/utils/DecksStorage.dart';
import 'package:flutter/material.dart';
import 'package:MagicFlutter/screens/base/Screen.dart';

class NewDeckScreen extends StatefulWidget {
  @override
  _NewDeckScreenState createState() => _NewDeckScreenState();
}

class _NewDeckScreenState extends State<NewDeckScreen> {
  DeckStorage storage = new DeckStorage();
  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Create new deck',
      child: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 7,
              decoration: InputDecoration(
                labelText: 'Description',
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  storage.createDeck('test', "description", [
                    {
                      "artist": "Collin Estrada",
                      "availability": ["arena", "mtgo", "paper"],
                      "borderColor": "black",
                      "colorIdentity": ["B", "G", "R", "U", "W"],
                      "colors": ["G"],
                      "convertedManaCost": 3.0,
                      "edhrecRank": 11120,
                      "faceName": "Esika, God of the Tree",
                      "foreignData": [],
                      "frameEffects": ["showcase", "legendary"],
                      "frameVersion": "2015",
                      "hasFoil": true,
                      "hasNonFoil": true,
                      "identifiers": {
                        "cardKingdomFoilId": "241163",
                        "cardKingdomId": "240488",
                        "mcmId": "530622",
                        "mcmMetaId": "328597",
                        "mtgArenaId": "75420",
                        "mtgjsonV4Id": "c790cf82-8e5a-596a-8e76-c9adfb83a0e9",
                        "multiverseId": "507666",
                        "scryfallId": "ced8571a-24e1-45be-8698-3314b663940a",
                        "scryfallIllustrationId": "ea8db8f5-415a-4c32-81c9-fb182733edd2",
                        "scryfallOracleId": "92023a5d-a143-4950-a71b-d736e6b8e959",
                        "tcgplayerProductId": "230289"
                      },
                      "isStarter": true,
                      "keywords": ["Vigilance"],
                      "layout": "modal_dfc",
                      "leadershipSkills": {
                        "brawl": true,
                        "commander": true,
                        "oathbreaker": false
                      },
                      "legalities": {
                        "brawl": "Legal",
                        "commander": "Legal",
                        "duel": "Legal",
                        "future": "Legal",
                        "gladiator": "Legal",
                        "historic": "Legal",
                        "legacy": "Legal",
                        "modern": "Legal",
                        "pioneer": "Legal",
                        "standard": "Legal",
                        "vintage": "Legal"
                      },
                      "manaCost": "{1}{G}{G}",
                      "name": "Esika, God of the Tree // The Prismatic Bridge",
                      "number": "314",
                      "originalText": "Vigilance\n{T}: Add one mana of any color.\nOther legendary creatures you control have vigilance and \"{T}: Add one mana of any color.\"\n\n\nEnchantment\n{W}{U}{B}{R}{G}",
                      "originalType": "Legendary Creature — God",
                      "otherFaceIds": [
                        "b8e15f58-1152-5c18-ae93-70ae50f71024"
                      ],
                      "power": "1",
                      "printings": ["KHM"],
                      "promoTypes": ["boosterfun"],
                      "purchaseUrls": {
                        "cardKingdom": "https://mtgjson.com/links/53f062b9d0b57f51",
                        "cardKingdomFoil": "https://mtgjson.com/links/b5aef2b1d60c4bba",
                        "cardmarket": "https://mtgjson.com/links/4417dc6819dfcf60",
                        "tcgplayer": "https://mtgjson.com/links/4584f1fa4e5fd7e2"
                      },
                      "rarity": "mythic",
                      "rulings": [
                        {
                          "date": "2021-02-05",
                          "text": "If a creature loses vigilance after it attacks (perhaps because Esika leaves the battlefield), that creature will continue attacking. It won’t become tapped."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "While resolving the triggered ability of The Prismatic Bridge, if there are no creature or planeswalker cards in your library, you’ll simply reveal your entire library, randomize it, and continue playing."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If you reveal a double-faced card whose front face is a creature or planeswalker, you’ll put it onto the battlefield with its front face up."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "There is a single triangle icon in the top left corner of the front face. There is a double triangle icon in the top left corner of the back face."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "To determine whether it is legal to play a modal double-faced card, consider only the characteristics of the face you’re playing and ignore the other face’s characteristics."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If an effect allows you to play a specific modal double-faced card, you may cast it as a spell or play it as a land, as determined by which face you choose to play. If an effect allows you to cast (rather than “play”) a specific modal double-faced card, you can’t play it as a land."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If an effect allows you to play a land or cast a spell from among a group of cards, you may play or cast a modal double-faced card with any face that fits the criteria of that effect."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "The converted mana cost of a modal double-faced card is based on the characteristics of the face that’s being considered. On the stack and battlefield, consider whichever face is up. In all other zones, consider only the front face. This is different than how the converted mana cost of a transforming double-faced card is determined."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "A modal double-faced card can’t be transformed or be put onto the battlefield transformed. Ignore any instruction to transform a modal double-faced card or to put one onto the battlefield transformed."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If an effect puts a double-faced card onto the battlefield, it enters with its front face up. If that front face can’t be put onto the battlefield, it doesn’t enter the battlefield."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If an effect instructs a player to choose a card name, the name of either face may be chosen. If that effect or a linked ability refers to a spell with the chosen name being cast and/or a land with the chosen name being played, it considers only the chosen name, not the other face’s name."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "In the Commander variant, a double-faced card’s color identity is determined by the mana costs and mana symbols in the rules text of both faces combined. If either face has a color indicator or basic land type, those are also considered."
                        }
                      ],
                      "setCode": "KHM",
                      "side": "a",
                      "subtypes": ["God"],
                      "supertypes": ["Legendary"],
                      "text": "Vigilance\n{T}: Add one mana of any color.\nOther legendary creatures you control have vigilance and \"{T}: Add one mana of any color.\"",
                      "toughness": "4",
                      "type": "Legendary Creature — God",
                      "types": ["Creature"],
                      "uuid": "04d0bed8-7fde-5991-9d53-27fc0732646a",
                      "variations": [
                        "51cea10e-7235-567e-9339-292571210ff5"
                      ]
                    },
                    {
                      "artist": "Collin Estrada",
                      "availability": ["arena", "mtgo", "paper"],
                      "borderColor": "black",
                      "colorIdentity": ["B", "G", "R", "U", "W"],
                      "colors": ["B", "G", "R", "U", "W"],
                      "convertedManaCost": 3.0,
                      "edhrecRank": 11120,
                      "faceName": "The Prismatic Bridge",
                      "foreignData": [],
                      "frameEffects": ["showcase", "legendary"],
                      "frameVersion": "2015",
                      "hasFoil": true,
                      "hasNonFoil": true,
                      "identifiers": {
                        "mcmId": "530622",
                        "mcmMetaId": "328597",
                        "mtgArenaId": "75420",
                        "mtgjsonV4Id": "ec8ce7bd-9f86-5120-924b-1c3230f5f635",
                        "multiverseId": "507665",
                        "scryfallId": "ced8571a-24e1-45be-8698-3314b663940a",
                        "scryfallIllustrationId": "cec1e872-2d6e-49ca-8935-12f05e1a017d",
                        "scryfallOracleId": "92023a5d-a143-4950-a71b-d736e6b8e959",
                        "tcgplayerProductId": "230289"
                      },
                      "isStarter": true,
                      "layout": "modal_dfc",
                      "legalities": {
                        "brawl": "Legal",
                        "commander": "Legal",
                        "duel": "Legal",
                        "future": "Legal",
                        "gladiator": "Legal",
                        "historic": "Legal",
                        "legacy": "Legal",
                        "modern": "Legal",
                        "pioneer": "Legal",
                        "standard": "Legal",
                        "vintage": "Legal"
                      },
                      "manaCost": "{W}{U}{B}{R}{G}",
                      "name": "Esika, God of the Tree // The Prismatic Bridge",
                      "number": "314",
                      "originalText": "At the beginning of your upkeep, reveal cards from the top of your library until you reveal a creature or planeswalker card. Put that card onto the battlefield and the rest on the bottom of your library in a random order.\n\n\nGod\n{1}{G}{G}",
                      "originalType": "Legendary Enchantment",
                      "otherFaceIds": [
                        "04d0bed8-7fde-5991-9d53-27fc0732646a"
                      ],
                      "printings": ["KHM"],
                      "promoTypes": ["boosterfun"],
                      "purchaseUrls": {
                        "cardmarket": "https://mtgjson.com/links/ede1d8befd09d394",
                        "tcgplayer": "https://mtgjson.com/links/49c3b885f4bc1582"
                      },
                      "rarity": "mythic",
                      "rulings": [
                        {
                          "date": "2021-02-05",
                          "text": "If a creature loses vigilance after it attacks (perhaps because Esika leaves the battlefield), that creature will continue attacking. It won’t become tapped."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "While resolving the triggered ability of The Prismatic Bridge, if there are no creature or planeswalker cards in your library, you’ll simply reveal your entire library, randomize it, and continue playing."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If you reveal a double-faced card whose front face is a creature or planeswalker, you’ll put it onto the battlefield with its front face up."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "There is a single triangle icon in the top left corner of the front face. There is a double triangle icon in the top left corner of the back face."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "To determine whether it is legal to play a modal double-faced card, consider only the characteristics of the face you’re playing and ignore the other face’s characteristics."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If an effect allows you to play a specific modal double-faced card, you may cast it as a spell or play it as a land, as determined by which face you choose to play. If an effect allows you to cast (rather than “play”) a specific modal double-faced card, you can’t play it as a land."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If an effect allows you to play a land or cast a spell from among a group of cards, you may play or cast a modal double-faced card with any face that fits the criteria of that effect."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "The converted mana cost of a modal double-faced card is based on the characteristics of the face that’s being considered. On the stack and battlefield, consider whichever face is up. In all other zones, consider only the front face. This is different than how the converted mana cost of a transforming double-faced card is determined."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "A modal double-faced card can’t be transformed or be put onto the battlefield transformed. Ignore any instruction to transform a modal double-faced card or to put one onto the battlefield transformed."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If an effect puts a double-faced card onto the battlefield, it enters with its front face up. If that front face can’t be put onto the battlefield, it doesn’t enter the battlefield."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "If an effect instructs a player to choose a card name, the name of either face may be chosen. If that effect or a linked ability refers to a spell with the chosen name being cast and/or a land with the chosen name being played, it considers only the chosen name, not the other face’s name."
                        },
                        {
                          "date": "2021-02-05",
                          "text": "In the Commander variant, a double-faced card’s color identity is determined by the mana costs and mana symbols in the rules text of both faces combined. If either face has a color indicator or basic land type, those are also considered."
                        }
                      ],
                      "setCode": "KHM",
                      "side": "b",
                      "subtypes": [],
                      "supertypes": ["Legendary"],
                      "text": "At the beginning of your upkeep, reveal cards from the top of your library until you reveal a creature or planeswalker card. Put that card onto the battlefield and the rest on the bottom of your library in a random order.",
                      "type": "Legendary Enchantment",
                      "types": ["Enchantment"],
                      "uuid": "b8e15f58-1152-5c18-ae93-70ae50f71024",
                      "variations": [
                        "1d918ac9-583f-5063-bfe9-c3a3597f21f4"
                      ]
                    }
                  ]);
                },
                child: Text('Create')
            ),
          ],
        ),
      )
    );
  }
}
