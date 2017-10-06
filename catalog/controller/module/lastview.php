<?php
class ControllerModuleLastview extends Controller {
    public function index($setting)
    {
        $this->load->language('module/lastview');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_tax'] = $this->language->get('text_tax');

        $data['button_cart'] = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare'] = $this->language->get('button_compare');

        $this->load->model('catalog/product');

        $this->load->model('tool/image');
        if (isset($this->request->get['product_id'])) {
            $result = $this->model_catalog_product->getProduct($this->request->get['product_id']);
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }

            if ((float)$result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $special = false;
            }

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
            } else {
                $tax = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = $result['rating'];
            } else {
                $rating = false;
            }

            /*code start*/
            if((strtotime(date('Y-m-d')) >= strtotime($result['promo_date_start'])) && (strtotime(date('Y-m-d')) <= strtotime($result['promo_date_end'])) || (($result['promo_date_start'] == '0000-00-00') && ($result['promo_date_end'] == '0000-00-00'))) {
                $promo_on = TRUE;
            } else {
                $promo_on = FALSE;
            }

            $promo = $this->model_catalog_product->getPromo($result['product_id'],$result['promo_top_right']);
            if ( !empty($promo_on) && !empty($promo) ) {
                $promotag = '<span class="promotags" style="width:100%;height:100%;background: url(\'' . 'image/' . $promo['image'] . '\') no-repeat;"></span>';
            } else {
                $promotag = '';
            }
            /*code end*/

            // Группа пользоватедля для доступа к категории
            $category_info = $this->model_catalog_product->getCategories($result['product_id']);

            if (!empty($category_info)) {
                $category_id_product = $category_info[0]['category_id'];
                $category_info = $this->model_catalog_product->getCategory($category_id_product);
                $customer_group_access = $category_info['customer_group_id'];

                if ( $customer_group_access == '1') {
                    $group_access = true;
                } else {
                    $group_access = false;
                }
            } else {
                $group_access = true;
            }

            if (isset($this->session->data['lastview'][$this->request->get['product_id']])) {
                unset($this->session->data['lastview'][$this->request->get['product_id']]);
            }
            $this->session->data['lastview'][$this->request->get['product_id']] = array(
                'product_id'        => $result['product_id'],
                'image'             => $result['image'],
                'name'              => $result['name'],
                'quantity'          => $result['quantity'],
                'description'       => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
                'description_short' => utf8_substr(strip_tags(html_entity_decode($result['description_short'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
                'price'             => $price,
                'special'           => $special,
                'tax'               => $tax,
                'rating'            => $rating,
                'group_access'      => $group_access,
                'href'              => $this->url->link('product/product', 'product_id=' . $result['product_id']),
                'promotag'	        => $promotag,
            );
        }
        $data['products'] = array();
        if (isset($this->session->data['lastview'])) {
            $results = $this->session->data['lastview'];
            $results = array_reverse($results);
            $i = 0;
            foreach ($results as $result) {
                if (isset($result['image']) && is_file(DIR_IMAGE . $result['image'])) {
                    $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
                }

                // Группа пользоватедля для доступа к категории
                $category_info = $this->model_catalog_product->getCategories($result['product_id']);

                if (!empty($category_info)) {
                    $category_id_product = $category_info[0]['category_id'];
                    $category_info = $this->model_catalog_product->getCategory($category_id_product);
                    $customer_group_access = $category_info['customer_group_id'];

                    if ( $customer_group_access == '1') {
                        $group_access = true;
                    } else {
                        $group_access = false;
                    }
                } else {
                    $group_access = true;
                }

                $data['products'][] = array(
                    'product_id'    => $result['product_id'],
                    'thumb'         => $image,
                    'name'          => $result['name'],
                    'quantity'      => $result['quantity'],
                    'description'   => $result['description'],
                    'description_short'   => $result['description_short'],
                    'price'         => $result['price'],
                    'special'       => $result['special'],
                    'tax'           => $result['tax'],
                    'rating'        => $result['rating'],
                    'group_access'  => $group_access,
                    'href'          => $result['href'],
                    'promotag'	    => $result['promotag']
                );
                $i++;
                if ($i == $setting['limit']) {
                    break;
                }
            }

            $data['languagese'] = $this->language->getGroupData();

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/lastview.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/module/lastview.tpl', $data);
            } else {
                return $this->load->view('default/template/module/lastview.tpl', $data);
            }
        }
    }
}