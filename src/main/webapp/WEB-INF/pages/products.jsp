<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>

<html>
    <head>
        <title>Products page!</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </head>

    <style>
        p {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3; /* number of lines to show */
            line-height: 1.8em;        /* fallback */
            max-height: 230px;       /* fallback */
        }

        h7.brand {
            font-style: italic;
            font-size: 13px;
        }

        h1 a:hover {
            text-decoration: none;
        }
    </style>

    <body>
        <div class="container" style="flex-wrap:wrap">
            <div class="row"><h1><a href="/products">Product listing</a></h1></div>
            <hr />

            <div class="row">
                <div class="col-2">Filter by category:</div>
                <div class="col-2">
                    <div class="dropdown category-filter">
                        <a class="btn btn-secondary btn-sm dropdown-toggle" href="#" role="button" id="category_filter" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Category
                        </a>

                        <div class="dropdown-menu" aria-labelledby="category_filter">
                            <a id=1 class="dropdown-item" href="/products?categories=1">Makeup > Face > Foundation</a>
                            <a id=2 class="dropdown-item" href="/products?categories=2">Makeup > Face > BB & CC Cream</a>
                            <a id=3 class="dropdown-item" href="/products?categories=3">Makeup > Face > Tinted Moisturizer</a>
                        </div>
                    </div>
                </div>

                <div class="col-2">Filter by price range:</div>
                <div class="col-2">
                    <div class="dropdown price-filter">
                        <a class="btn btn-secondary btn-sm dropdown-toggle" href="#" role="button" id="price_filter" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Price range
                        </a>

                        <div class="dropdown-menu" aria-labelledby="price_filter">
                            <a id=5 class="dropdown-item" href="/products?start_price_range=5&end_price_range=20">$5 to $20</a>
                            <a id=21 class="dropdown-item" href="/products?start_price_range=21&end_price_range=39">$21 to $39</a>
                            <a id=40 class="dropdown-item" href="/products?start_price_range=40">$40 and above</a>
                        </div>
                    </div>
                </div>

                <div class="col-4">
                    <a href="/products" class="btn btn-primary btn-sm active" role="button" aria-pressed="true">Reset</a>
                </div>
            </div>

            <div class="row">
                <div class="col-2">Selection: </div>
                <div class="col-2"><label id="cat_selection" style="font-size: 11px; margin-top:5px"></label></div>
                <div class="col-2">Selection: </div>
                <div class="col-2"><label id="price_selection" style="font-size: 11px; margin-top:5px"></label></div>
                <div class="col-4">&nbsp;</div>
            </div>

            <hr />

            <!-- Row 1 -->
            <c:if test="${resultRow > 0 && resultProduct != null}">
                <c:if test="${totalResult > 8}">
                    <c:set var="pageVal" value="1" scope="page" />
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-end">
                            <li class="page-item">
                                <a class="page-link" href="/products?page_no=${pageVal}" tabindex="-1" aria-disabled="true">Previous</a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>

                            <c:if test="${resultRow > 1}">
                                <c:forEach var = "pageNo" begin = "2" end = "${resultRow-1}">
                                    <li class="page-item"><a class="page-link" href="#">${pageNo}</a></li>
                                    <c:set var="pageVal" value="${pageVal + 1}" scope="page" />
                                </c:forEach>
                            </c:if>

                            <li class="page-item">
                                <a class="page-link" href="/products?page_no=${pageVal}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>

                <label>Total Record: ${totalResult}</label>

                <c:set var="counter" value="0" scope="page" />
                <c:forEach var = "rowNo" begin = "0" end = "2">
                    <div class="row">
                        <div class="col">
                        <div class="card-deck">
                        <c:forEach var = "colNo" begin = "${rowNo*0}" end = "3">
                            <c:if test="${(counter) < resultProduct.size()}">
                                    <div class="card" style="width: 16rem;">
                                        <img src="#" class="card-img-top" alt="image holder" style="height: 250px">
                                        <div class="card-body">
                                            <h5 class="card-title">${resultProduct.get(counter).title}</h5>
                                            <h7 class="card-text brand">${resultProduct.get(counter).brandName}</h7>
                                            <p class="card-text">${resultProduct.get(counter).description}</p>
                                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#detailModal" data-seqval="${counter}"}>View Detail</a>
                                        </div>
                                    </div>
                            </c:if>
                            <c:if test="${(counter) >= resultProduct.size()}">
                                <div class="col">&nbsp;</div>
                            </c:if>
                            <c:set var="counter" value="${counter + 1}" scope="page" />
                        </c:forEach>
                        </div>
                        </div>
                    </div>
                    <hr />
                </c:forEach>
            </c:if>

            <c:if test="${resultRow==0 || resultProduct == null}">
                <label>Total Record: 0</label>
            </c:if>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModal" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="Product Detail">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="row">
                    <div class="col-3">SKU:</div>
                    <div class="col-9 modal-body-sku"></div>
                </div>
                <div class="row">
                    <div class="col-3">Brand:</div>
                    <div class="col-9 modal-body-brand"></div>
                </div>
                <div class="row" style="margin-top: 20px">
                    <div class="col-3">Description:</div>
                    <div class="col-9 modal-body-desc"></div>
                </div>
                <div class="row" style="margin-top: 20px">
                    <div class="col-3">Selling Price:</div>
                    <div class="col-9 modal-body-selling-price"></div>
                </div>
                <div class="row">
                    <div class="col-3">Quantity available:</div>
                    <div class="col-9 modal-body-qty"></div>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>

        <script>
            var urlParams = new URLSearchParams(location.search);
            if(urlParams.has('categories')) {
                $(".category-filter div a").each(function () {
                    if($(this).attr('id')==urlParams.get('categories')) {
                        $("#cat_selection").text($(this).text());
                    }
                })
            } else if(urlParams.has('start_price_range')) {
                $(".price-filter div a").each(function () {
                    if($(this).attr('id')==urlParams.get('start_price_range')) {
                        $("#price_selection").text($(this).text());
                    }
                })
            }

            $('#detailModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget) // Button that triggered the modal
                var seq_val = button.data('seqval') // Extract info from data-* attributes
                var modal = $(this)
                <c:if test="${resultProduct != null && resultProduct.size() > 0}">
                    <c:forEach var = "seq" begin = "0" end = "${resultProduct.size()-1}">
                        if(seq_val==${seq}) {
                            modal.find('.modal-title').text('${resultProduct.get(seq).title}')
                            modal.find('.modal-body .modal-body-brand').text('${resultProduct.get(seq).brandName}')
                            modal.find('.modal-body .modal-body-desc').html('${StringEscapeUtils.escapeEcmaScript(resultProduct.get(seq).description.replaceAll("(\\r\\n|\\n)", "<br>"))}')
                            modal.find('.modal-body .modal-body-sku').text('${resultProduct.get(seq).sku}')
                            modal.find('.modal-body .modal-body-selling-price').text('${resultProduct.get(seq).sellingPrice}')
                            modal.find('.modal-body .modal-body-qty').text('${resultProduct.get(seq).qty}')
                        }
                    </c:forEach>
                </c:if>
            })
        </script>

    </body>
</html>



