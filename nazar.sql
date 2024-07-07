INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('collector_card', 'Collector Card', 12, 1, 'item_standard', 1)
    ON DUPLICATE KEY UPDATE `item`='collector_card', `label`='Collector Card', `limit`=12, `can_remove`=1, `type`='item_standard', `usable`=1;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES ('collector_card_box', 'Collector Card', 10, 1, 'item_standard', 1, 'A box to store cards of specific set.')
    ON DUPLICATE KEY UPDATE `item`='collector_card_box', `label`='Card Box', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=1, `desc` = 'A box to store cards of specific set.';
